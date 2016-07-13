require('sinatra')
require('sinatra/reloader')

also_reload('lib/**/*.rb')


get('/') do
  @page_title = "home"
  erb(:index)
end