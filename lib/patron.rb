class Patron
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes[:id] || nil
    @name = attributes[:name]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |another_patron|
    # self.name().==(another_patron.name()).&(self.id().==(another_patron)))
    self.name == another_patron.name && self.id == another_patron.id
  end

  define_method(:update) do | attributes |
    @name = attributes[:name]
    @id = self.id()
    DB.exec("update patrons set name ='#{@name}' where id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("delete from patrons where id = #{self.id()};")
  end

  define_method(:checkout) do | attributes |
    book_id = attributes.fetch(:book_id, nil)
    ck_time = DateTime.now
    due_time = DateTime.now + 14
    DB.exec("insert into checkout (book_id, patron_id, date, due)
             values (#{book_id.to_i}, #{self.id}, '#{ck_time}', '#{due_time}');")
  end

  define_method(:checkin) do | attributes |
    book_id = attributes.fetch(:book_id, nil)
    DB.exec("update checkout set returned = '#{DateTime.now}' where book_id = #{book_id} and patron_id = #{self.id}")
  end

  define_method(:books) do
    patron_books = []
    results = DB.exec("select book_id from checkout where patron_id = #{self.id}")
    results.each do | result |
      book_id = result.fetch('book_id').to_i
      book = DB.exec("select * from books where id = #{book_id}")
      name = book.first().fetch('name')
      patron_books.push(Book.new({:name => name, :id => book_id}))
    end
    patron_books
  end

  # class methods
  define_singleton_method(:all) do
    returned_patrons = DB.exec('SELECT * FROM patrons order by name asc;')
    results = []
    returned_patrons.each() do | patron |
      results.push(Patron.new({:id => patron.fetch('id').to_i, :name => patron.fetch('name')}))
    end
    results
  end

  define_singleton_method(:find) do | id |
    patron_single = DB.exec("SELECT * FROM patrons WHERE id = #{id} limit 1;")
    found_patron = nil
    patron_single.each() do | patron |
      found_patron = Patron.new({:id => patron.fetch('id').to_i, :name => patron.fetch('name')})
    end
    found_patron
  end
end
