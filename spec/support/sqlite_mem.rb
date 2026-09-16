# Load schema onto sqlite in memory

RSpec.configure do |config|
  config.before(:suite) do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
    ActiveRecord::Schema.verbose = false
    load "#{Rails.root}/db/schema.rb"
  end
end
