
module SBDB
	class Cursor
		NEXT  = Bdb::DB_NEXT
		FIRST = Bdb::DB_FIRST
		LAST  = Bdb::DB_LAST
		PREV  = Bdb::DB_PREV
		SET   = Bdb::DB_SET

		attr_reader :db

		include Enumerable
		def bdb_object
			@cursor
		end
		def close
			@cursor.close
		end
		def get key, val, flg
			@cursor.get key, val, flg
		end
		def count
			@cursor.count
		end
		def first key = nil, val = nil
			get key, val, FIRST
		end
		def last key = nil, val = nil
			get key, val, LAST
		end 
		def next key = nil, val = nil
			get key, val, NEXT
		end 
		def prev key = nil, val = nil
			get key, val, PREV
		end

		def self.new *ps
			ret = obj = super( *ps)
			begin ret = yield obj
			ensure obj.close
			end  if block_given?
			ret
		end

		def initialize ref
			@cursor, @db = *case ref
				when Cursor  then [ref.bdb_object.dup, ref.db]
				when Bdb::Db::Cursor  then [ref]
				else [ref.bdb_object.cursor( nil, 0), ref]
				end
			if [Recno, Queue].any? {|dbt| dbt === @db }
				def get *ps
					key, val = @cursor.get( *ps)
					key.nil? ? nil : [key.unpack('I')[0], val]
				end
			end
		end

		def reverse key = nil, val = nil, &exe
			each key, val, LAST, PREV, &exe
		end

		def each key = nil, val = nil, flg = nil, nxt = nil
			return Enumerator.new( self, :each, key, val, flg, nxt)  unless block_given?
			nxt ||= NEXT
			ent = get key, val, flg || FIRST
			return  unless ent
			yield *ent
			yield *ent  while ent = get( key, val, nxt)
			nil
		end
	end
end
