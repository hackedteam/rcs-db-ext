# gene_pool

* http://github.com/bpardee/gene_pool

## DESCRIPTION:

Generic pooling library for connection pools.

## FEATURES/PROBLEMS:

* Thread-safe
* Pure ruby

## INSTALL:

  gem install gene_pool

## EXAMPLE USAGE:

      class MyClient
        # Print a logger warning if it requires more than 0.25 seconds to acquire a connection.
        # Close and reopen the connection if it hasn't been used for 10 seconds.
        # Raise Timeout::Error if waiting for a connection more than 3 seconds.
        @@gene_pool = GenePool.new(:name         => 'MyClient',
                                   :pool_size    => 10,
                                   :timeout      => 3,
                                   :warn_timeout => 0.25,
                                   :idle_timeout => 10,
                                   :logger       => Rails.logger,
                                   :close_proc   => :close) do
          TCPSocket.new('myserver', 4321)
        end

        def send_message
          @@gene_pool.with_connection do |socket|
            begin
              # use socket here
            rescue Exception => e
              # If the socket gets closed, remove it from the pool
              @@gene_pool.remove(socket)
            end
          end
        end

        # Equivalent to send_message above
        def send_message_auto_remove
          # On exception, close and reopen socket and perform retry
          @@gene_pool.with_connection_auto_remove do |socket|
            # use socket here,
          end
        end

        def send_message_auto_retry
          # On exception, close and reopen socket and perform retry
          @@gene_pool.with_connection_auto_retry do |socket|
            # use socket here,
          end
        end
      end

## Copyright

Copyright (c) 2010-2012 Brad Pardee. See LICENSE for details.
