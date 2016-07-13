require('rspec')
require('pg')
require('author')
require('patron')


DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do | config |
  config.after(:each) do
    DB.exec("delete from authors *;")
    DB.exec("delete from patrons *;")
  end
end
