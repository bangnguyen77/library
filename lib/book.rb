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

  define_method(:==) do |another_book|
    # self.name().==(another_book.name()).&(self.id().==(another_book)))
    self.name == another_book.name && self.id == another_book.id
  end

  define_method(:update) do | attributes |
    @name = attributes[:name]
    @id = self.id()
    DB.exec("update books set name ='#{@name}' where id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("delete from books where id = #{self.id()};")
  end
end
