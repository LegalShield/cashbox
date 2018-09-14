$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'pry'
require 'cashbox'
require 'rspec/its'
require 'active_record'
require 'sqlite3'
require 'database_cleaner'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.before(:suite) do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'test_database.sql'
    )

    DatabaseCleaner.clean_with(:deletion)
    DatabaseCleaner.clean

    unless ActiveRecord::Base.connection.table_exists? 'cashbox_logs'
      ActiveRecord::Schema.define do
        create_table :cashbox_logs do |t|
          t.text "uuid"
          t.text "operation"
          t.text "method"
          t.text "url"
          t.text "headers"
          t.text "body"

          t.timestamps
        end
      end
    end

  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end
end

Dir[File.dirname(__FILE__) + '/support/helpers/*.rb'].each {|f| require(f) }
Dir[File.dirname(__FILE__) + '/support/matchers/*.rb'].each {|f| require(f) }
