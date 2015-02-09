require 'bdb'
require 'ref'
require 'sbdb/environment'
require 'sbdb/db'
require 'sbdb/cursor'
require 'sbdb/transaction'

module SBDB
	CREATE      = Bdb::DB_CREATE
	AUTO_COMMIT = Bdb::DB_AUTO_COMMIT
	RDONLY      = Bdb::DB_RDONLY
	READONLY    = RDONLY

	def btree( *ps)   Btree.new *ps   end
	def hash( *ps)    Hash.new *ps    end
	def recno( *ps)   Recno.new *ps   end
	def queue( *ps)   Queue.new *ps   end 
	def unknown( *ps) Unknown.new *ps end
	alias open_db unknown

	def self.raise_barrier *ps, &e
		e.call *ps
	rescue Object
		$stderr.puts [$!.class,$!,$!.backtrace].inspect
	end
end
