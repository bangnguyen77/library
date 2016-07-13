require("capybara/rspec")
require("./app")
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do | config |
  config.after(:each) do
    DB.exec("delete from authors *;")
  end
end
