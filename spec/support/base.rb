require 'active_record'
require_relative './data'
require_relative './models'
require_relative './schema'

module Support
  module Base
    def self.init_or_refresh_data
      connect
      Schema.init_or_create_tables
      Data.execute
    end

    def self.connect
      adapter = 'sqlite3'
      ActiveRecord::Base.establish_connection(adapter: adapter, database: ':memory:')
    end
  end
end
