require('sinatra')
require('sinatra/reloader')
require('pg')
require('./lib/author')
require('./lib/patron')
require('./lib/book')

also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  @page_title = "home"
  @users = Patron.all()
  erb(:index)
end

get('/signup') do
  @page_title = "home"
  erb(:signup)
end

post('/patrons/add') do
  @page_title = "patron"
  patron = Patron.new({:name => params.fetch('name')})
  patron.save()
  redirect to('/')
end

post('/patrons') do
  @page_title = "patron"
  if params.fetch('patron').to_i > 0
    redirect to("/patrons/#{params.fetch('patron')}")
  else
    redirect to('/')
  end
end

get('/patrons/:id') do
  @page_title = "patron"
  @patron = Patron.find(params.fetch('id'))
  erb(:patrons)
end

get('/admin') do
  @page_title = "admin"
  @authors = Author.all
  @books = Book.all
  erb(:admin)
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

get('/admin/books') do
  @page_title = "admin"
  @books = Book.all()
  erb(:books)
end

post('/admin/books') do
  @page_title = "admin"
  new_book = Book.new({:name => params.fetch('name')})
  new_book.save()
  redirect to('/admin/books')
end

get('/admin/books/:id/edit') do
  @page_title = "admin"
  @book = Book.find(params.fetch('id').to_i)
  erb(:books_edit)
end

patch('/admin/books/:id/edit') do
  @page_title = "admin"
  id = params.fetch('id').to_i
  name = params.fetch('name')
  book = Book.find(id)
  book.update({:name => name})
  redirect to('/admin/books')
end

delete('/admin/books/:id/delete') do
  @page_title = "admin"
  id = params.fetch('id').to_i
  book = Book.find(id)
  book.delete()
  redirect to('/admin/books')

end
