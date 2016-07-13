require('rspec')
require('pg')
require('author')
require('patron')
require('book')


DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do | config |
  config.after(:each) do
    DB.exec("delete from authors *;")
    DB.exec("delete from patrons *;")
    DB.exec("delete from books *;")
  end
end
