# Copyright (c) 2010 ActiveState Software Inc. All rights reserved.

"""
    pypm.common.util
    ~~~~~~~~~~~~~~~~
    
    Assorted utility code
"""

import os
from os import path as P
import sys
import re
from contextlib import contextmanager
import logging
import time
import textwrap
from datetime import datetime

from pkg_resources import Requirement
from pkg_resources import resource_filename
import six

import pypm
from zclockfile import LockFile

LOG = logging.getLogger(__name__)


# Language/library utilities
#####################################################################

def wrapped(txt, prefix='', **options):
    """Return wrapped text suitable for printing to terminal"""
    MAX_WIDTH=70 # textwrap.wrap's default
    return '\n'.join([
            '{0}{1}'.format(prefix, line)
            for line in textwrap.wrap(txt, width=MAX_WIDTH-len(prefix), **options)])


def lazyproperty(func):
    """A property decorator for lazy evaluation"""
    cache = {}
    def _get(self):
        """Return the property value from cache once it is calculated"""
        try:
            return cache[self]
        except KeyError:
            cache[self] = value = func(self)
            return value
        
    return property(_get)


def memoize(fn):
    """Memoize functions that take simple arguments

    The arugments of this function must be 'hashable'

    Keywords are not supported
    """
    memo = {}
    def wrapper(*args):
        key = tuple(args)
        if key not in memo:
            memo[key] = fn(*args)
        return memo[key]
    return wrapper


class ConfigParserNamedLists(object):
    """Parse a named mapping from the configuration file.

    Example input (config file):

       [packages]
       free = http://pypm-free.as.com
       be = http://pypm-be.as.com
       staging = http://pypm-staging.as.com

       default = be free
       QA = staging default

    What this class produces (self.mapping):

       {
           'free': [factory('free', 'http://pypm-free.as.com')],
           'be': [factory('be', 'http://pypm-be.as.com')],
           'staging': [factory('staging', 'http://pypm-staging.as.com')],
           'default': [factory('be', 'http://pypm-be.as.com'),
                       factory('free', 'http://pypm-free.as.com')],
           'QA': [factory('staging', 'http://pypm-staging.as.com'),
                  factory('be', 'http://pypm-be.as.com'),
                  factory('free', 'http://pypm-free.as.com')],
       }
    """
    
    VALUE_SEP = re.compile('[\s,]+')

    def __init__(self, option_items, factory, is_sentinel):
        """
        - option_items: ConfigParser.items('yoursection')
        - factory: a function that produces the value object
        - sentinel_p: a function that returns True for sentinels
        """
        self.option_items = option_items
        self.factory = factory
        self.is_sentinel = is_sentinel
        self.mapping = {}
        self._init()

    def _init(self):
        for name, value in self.option_items:
            if name in self.mapping:
                raise ValueError('duplicate option key found: {0}'.format(name))
            else:
                self.mapping[name] = value

        # substitute references
        _processed = set()
        for name in self.mapping:
            self._expand_rvalue(name, _processed)

    def _expand_rvalue(self, name, processed):
        if name in processed:
            return
        value = self.mapping[name]
        
        if isinstance(value, list):
            processed.add(name)
            return

        if name not in self.mapping:
            raise ValueError('unknown option reference: {0}'.format(name))

        if self.is_sentinel(value):
            self.mapping[name] = [self.factory(name, value)]
        else:
            self.mapping[name] = []
            for part in self.VALUE_SEP.split(value):
                self._expand_rvalue(part, processed)
                self.mapping[name].extend(self.mapping[part])
                


# System routines
######################################################################

@contextmanager
def locked(lockfile):
    """'with' context to lock a file"""
    lock = LockFile(lockfile)
    try:
        yield
    finally:
        lock.close()
        

@contextmanager
def dlocked(directory):
    """Lock based on a directory
    
    You need this function if you do not want more than on process to be
    operating on a directory
    """
    if not P.exists(directory):
        os.makedirs(directory)
    lockfile = P.join(directory, '.lock')
    with locked(lockfile):
        yield


def get_user_agent(default):
    """Return an user agent string representing PyPM
    
    Retain the default user-agent for backward-compat
    """
    return '{0} (PyPM {1.__version__})'.format(default, pypm)



# Path routines
# ########################################################################

def existing(path):
    """Return path, but assert its presence first"""
    assert isinstance(path, (six.string_types, six.text_type)), \
        'not of string type: %s <%s>' % (path, type(path))
    assert P.exists(path), 'file/directory not found: %s' % path
    return path


def concise_path(pth):
    """Return a concise, but human-understandable, version of ``pth``

    Compresses %HOME% and %APPDATA%
    """
    aliases = [
        ('%APPDATA%', os.getenv('APPDATA', None)),
        ('~',         P.expanduser('~')),
    ]
    for alias, pthval in aliases:
        if pthval and pth.startswith(pthval):
            return P.join(alias, P.relpath(pth, pthval))
    return pth


def abs2rel(absolute_path):
    """Convert an absolute path to relative path assuming the topmost directory
    is the bast dir.
    
    >>> strip_abs_root('/opt/ActivePython/')
    'opt/ActivePython/'
    >>> strip_abs_root('/opt/ActivePython')
    'opt/ActivePython'
    """
    assert os.path.isabs(absolute_path), \
        '`%s` is not a absolute path' % absolute_path
    if sys.platform.startswith('win'):
        assert absolute_path[1:3] == ':\\'
        return absolute_path[3:]  # remove the DRIVE
    else:
        assert absolute_path[0] == '/'
        return absolute_path[1:]  # remove the '/'
        

def url_join(url, components):
    """Join URL components .. always with a forward slash"""
    assert type(components) is list
    assert '\\' not in url, \
        'URL is not supposed to contain backslashes. Is this windows path? '+url
    return url + '/' + '/'.join(components)
    

def path_to_url(path):
    """Convert local path to remote url
    """
    if sys.platform.startswith('win'):
        assert '/' not in path, \
            'windows path cannot contain forward slash: '+path
        drive, path = os.path.splitdrive(path)
        return url_join('file:///' + drive,
                        path.split('\\'))
    else:
        return 'file://' + P.abspath(path)


def pypm_file(*paths):
    """Return absolute path to a file residing inside the pypm package using
    pkg_resources API"""
    return resource_filename(Requirement.parse('pypm'), P.join(*paths))



class BareDateTime(six.text_type):
    """Wrapper around the DateTime object with our own standard string
    representation
    """

    DATE_FORMAT = "%Y-%m-%d"
    TIME_FORMAT = "%H:%M:%S"
    FORMAT = DATE_FORMAT + ' ' + TIME_FORMAT

    @classmethod
    def to_string(cls, dt):
        """Convert the datetime object `dt` to a string

        with format as defind by this class
        """
        return dt.strftime(cls.FORMAT)

    @classmethod
    def to_datetime(cls, dt_string):
        """Convert dt_string, formatted by `to_string()` method above"""
        ts = time.mktime(time.strptime(dt_string, cls.FORMAT))
        return datetime.fromtimestamp(ts)

