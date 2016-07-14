class Book
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes[:id] || nil
    @name = attributes[:name]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |another_book|
    # self.name().==(another_book.name()).&(self.id().==(another_book)))
    self.name == another_book.name && self.id == another_book.id
  end

  define_method(:update) do | attributes |
    @name = attributes.fetch(:name, @name)
    DB.exec("update books set name ='#{@name}' where id = #{self.id};")

    attributes.fetch(:author_ids, []).each do | author_id |
      DB.exec("insert into books_authors (author_id, book_id) values(#{author_id}, #{self.id});")
    end
  end

  define_method(:delete) do
    DB.exec("delete from books_authors where book_id = #{self.id}")
    DB.exec("delete from books where id = #{self.id()};")
  end

  define_method(:authors) do
    book_authors = []
    results = DB.exec("select author_id from books_authors where book_id = #{self.id};")
    results.each() do | result |
      author_id = result.fetch('author_id').to_i
      author = DB.exec("select * from authors where id = #{author_id};")
      name = author.first().fetch('name')
      book_authors.push(Author.new({:name => name, :id => author_id}))
    end
    book_authors
  end
  
  # class methods
  define_singleton_method(:all) do
    returned_books = DB.exec('SELECT * FROM books order by name asc;')
    results = []
    returned_books.each() do | book |
      results.push(Book.new({:id => book.fetch('id').to_i, :name => book.fetch('name')}))
    end
    results
  end

  define_singleton_method(:find) do | id |
    book_single = DB.exec("SELECT * FROM books WHERE id = #{id} limit 1;")
    found_book = nil
    book_single.each() do | book |
      found_book = Book.new({:id => book.fetch('id').to_i, :name => book.fetch('name')})
    end
    found_book
  end
end
