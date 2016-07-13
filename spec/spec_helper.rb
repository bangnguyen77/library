require('rspec')
require('pg')
require('author')


DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do | config |
  config.after(:each) do
    DB.exec("delete from authors *;")
  end
end
