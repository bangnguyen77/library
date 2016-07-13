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
end
