require('sinatra')
require('sinatra/reloader')
require('pg')
require('./lib/author')

also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  @page_title = "home"
  erb(:index)
end

get('/admin/authors') do
  @page_title = "admin"
  @authors = Author.all()
  erb(:authors)
end

post('/admin/authors') do
  @page_title = "admin"
  new_author = Author.new({:name => params.fetch('name')})
  new_author.save()
  redirect to('/admin/authors')
end

get('/admin/authors/:id/edit') do
  @page_title = "admin"
  @author = Author.find(params.fetch('id').to_i)
  erb(:authors_edit)
end

patch('/admin/authors/:id/edit') do
  @page_title = "admin"
  id = params.fetch('id').to_i
  name = params.fetch('name')
  author = Author.find(id)
  author.update({:name => name})
  redirect to('/admin/authors')
end

delete('/admin/authors/:id/delete') do
  @page_title = "admin"
  id = params.fetch('id').to_i
  author = Author.find(id)
  author.delete()
  redirect to('/admin/authors')

end
