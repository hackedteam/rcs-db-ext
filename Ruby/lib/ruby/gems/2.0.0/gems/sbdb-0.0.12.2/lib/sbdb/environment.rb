require 'bdb'
require 'sbdb/db'
require 'sbdb/transaction'

module SBDB
	# Environments are for storing one or more databases and are important
	# if you want to work with more than one process on one database.
	# You needn't use Environment,  but it's usefull.
	class Environment
		INIT_TXN   = Bdb::DB_INIT_TXN
		INIT_LOCK  = Bdb::DB_INIT_LOCK
		INIT_LOG   = Bdb::DB_INIT_LOG
		INIT_MPOOL = Bdb::DB_INIT_MPOOL
		INIT_TRANSACTION = INIT_TXN | INIT_LOCK | INIT_LOG | INIT_MPOOL
		LOCKDOWN   = Bdb::DB_LOCKDOWN
		NOMMAP     = Bdb::DB_NOMMAP
		PRIVATE    = Bdb::DB_PRIVATE
		SYSTEM_MEM = Bdb::DB_SYSTEM_MEM
		TXN_NOSYNC = Bdb::DB_TXN_NOSYNC
		LOG_DIRECT = Bdb::DB_LOG_DIRECT
		LOG_DSYNC  = Bdb::DB_LOG_DSYNC
		LOG_AUTO_REMOVE = Bdb::DB_LOG_AUTO_REMOVE
		LOG_IN_MEMORY = Bdb::DB_LOG_IN_MEMORY
		LOG_ZERO   = Bdb::DB_LOG_ZERO

		# returns the Bdb-object.
		def bdb_object()  @env  end
		# Opens a Btree in this Environment
		def btree file, *ps, &exe
			open Btree, file, *ps, &exe
		end 
		# Opens a Hash in this Environment
		def hash file, *ps, &exe
			open Hash, file, *ps, &exe
		end 
		# Opens a Recno in this Environment
		def recno file, *ps, &exe
			open Recno, file, *ps, &exe
		end 
		# Opens a Queue in this Environment
		def queue file, *ps, &exe
			open Queue, file, *ps, &exe
		end 
		# Opens a DB of unknown type in this Environment
		def unknown file, *ps, &exe
			open Unknown, file, *ps, &exe
		end 

		def transaction flg = nil, &exe
			SBDB::Transaction.new self, flg, &exe
		end
		alias txn transaction

		# args:
		#   args[0] => dir
		#   args[1] => flags
		#   args[3] => mode
		# possible options (via Hash):
		#	  :dir, :flags, :mode, :log_config
		def initialize *args
			opts = ::Hash === args.last ? args.pop : {}
			opts = {:dir => args[0], :flags => args[1], :mode => args[2]}.update opts
			@dbs, @env = Ref::WeakValueMap.new, Bdb::Env.new( 0)
			@env.log_config opts[:log_config], 1  if opts[:log_config]
			@env.lg_bsize = opts[:lg_bsize]  if opts[:lg_bsize]
			@env.lg_max = opts[:lg_max]  if opts[:lg_max]
			begin @env.open opts[:dir]||'.', opts[:flags]|| INIT_TRANSACTION|CREATE, opts[:mode]||0
			rescue Object
				close
				raise
			end
		end

		def self.new *args
			obj = ret = super( *args)
			begin ret = yield obj
			ensure SBDB::raise_barrier &obj.method(:close)
			end  if block_given?
			ret
		end

		# Close the Environment.
		# First you should close all databases!
		def close
			@dbs.each{|key, db|db.close}
			@env.close
		end

		class << self
			alias open new
		end

		# Opens a Database.
		# see SBDB::DB, SBDB::Btree, SBDB::Hash, SBDB::Recno, SBDB::Queue
		def open type, file, *ps, &exe
			ps.push ::Hash.new  unless ::Hash === ps.last
			ps.last[:env] = self
			(type || SBDB::Unkown).new file, *ps, &exe
		end
		alias db open
		alias open_db open

		# Returns the DB like open, but if it's already opened,
		# it returns the old instance.
		# If you use this, never use close. It's possible somebody else use it too.
		# The Databases, which are opened, will close, if the Environment will close.
		def [] file, *ps, &exe
			opts = ::Hash === ps.last ? ps.pop : {}
			opts[:env] = self
			name, type, flg = ps[0] || opts[:name], ps[1] || opts[:type], ps[2] || opts[:flags]
			ps.push opts
			@dbs[ [file, name, flg | CREATE]] ||= (type || SBDB::Unknown).new file, *ps, &exe
		end
	end
	Env = Environment
end
