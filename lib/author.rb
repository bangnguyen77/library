class Author
  attr_reader(:id, :name)

  define_method(:initialize) do | attributes |
    @id = attributes[:id] || nil
    @name = attributes[:name]
  end

  define_method(:save) do
    result = DB.exec("insert into authors (name) values ('#{@name}') returning id;")
    @id = result.first().fetch('id').to_i
  end

  define_method(:==) do | another_author |
    self.name().==(another_author.name()).&(self.id().==(another_author.id()))
  end

  define_method(:update) do | attributes |
    @name = attributes[:name]
    @id = self.id()
    DB.exec("update authors set name ='#{@name}' where id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("delete from authors where id = #{self.id()};")
  end

  define_singleton_method(:find) do | id |
    author_single = DB.exec("select * from authors where id = #{id} limit 1;")
    found_author = nil
    author_single.each() do | author |
      found_author = Author.new({:id => author.fetch('id').to_i, :name => author.fetch('name')})
    end
    found_author
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec('select * from authors order by name asc;')
    results = []
    returned_authors.each() do | author |
      results.push(Author.new({:id => author.fetch('id').to_i, :name => author.fetch('name')}))
    end
    results
  end

end
