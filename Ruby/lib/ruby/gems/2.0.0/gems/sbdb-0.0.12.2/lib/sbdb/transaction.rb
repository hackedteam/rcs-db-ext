require 'sbdb'
require 'bdb'

module SBDB
	class Transaction
		NOSYNC = Bdb::DB_TXN_NOSYNC
		SYNC = Bdb::DB_TXN_SYNC
		NOWAIT = Bdb::DB_TXN_NOWAIT
		WRITE_NOSYNC = Bdb::DB_TXN_WRITE_NOSYNC
		SNAPSHOT = Bdb::DB_TXN_SNAPSHOT
		READ_COMMITED = Bdb::DB_READ_COMMITTED
		READ_UNCOMMITED = Bdb::DB_READ_UNCOMMITTED

		def bdb_object()  @txn  end

		def self.new *p, &e
			r = obj = super( *p)
			begin
				r = e.call obj
			rescue Object
				obj.abort
				raise $!
			ensure
				obj.commit
			end  if e
			r
		end

		def initialize env, flags = nil, parent = nil
			@txn = env.bdb_object.txn_begin parent, flags || 0
		end

		def commit flags = nil
			@txn.commit flags || 0
		end

		def abort
			@txn.abort
		end
	end
	TXN = Transaction
end
