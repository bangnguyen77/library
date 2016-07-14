require "spec_helper"


describe(Author) do
  describe('#name') do
    it('will return an Author name') do
      new_author = Author.new({:name => "Test Test"})
      expect(new_author.name()).to(eq('Test Test'))
    end
  end

  describe('#save') do
    it('will save an Author to the database') do
      new_author = Author.new({:name => "Test Test"})
      new_author.save()
      expect(Author.all()).to(eq([new_author]))
    end
  end

  describe('#id') do
    it('will return the id of an Author') do
      new_author = Author.new({:name => "Test Test", :id => 1})
      expect(new_author.id()).to(eq(1))
    end
  end

  describe('.find') do
    it('will return an author by ID') do
      new_author = Author.new({:name => "Test Test"})
      new_author.save()
      expect(Author.find(new_author.id())).to(eq(new_author))
    end
  end

  describe("#==") do
    it('will ensure the Author objects are equal') do
      new_author1 = Author.new({:name => "Test Test"})
      new_author2 = Author.new({:name => "Test Test"})
      expect(new_author1).to(eq(new_author2))
    end
  end

  describe('.all') do
    it('will return a list of all Authors') do
      new_author1 = Author.new({:name => "Test Test"})
      new_author1.save()
      expect(Author.all()).to(eq([new_author1]))
    end
  end

  describe('#delete') do
    it('will delete an Author') do
      new_author1 = Author.new({:name => "Test Test"})
      new_author1.save()
      new_author2 = Author.new({:name => "Test Test"})
      new_author2.save()
      new_author1.delete()
      expect(Author.all()).to(eq([new_author2]))
    end
  end

  describe('#update') do
    it('will update an Author object') do
      new_author1 = Author.new({:name => "Test Test"})
      new_author1.save()
      new_author1.update({:name => 'Other Test'})
      expect(new_author1.name()).to(eq("Other Test"))
    end

    it('returns all of the authors of a book') do
      new_book1 = Book.new({:name => "Learn Ruby"})
      new_book1.save()
      new_book2 = Book.new({:name => "More Ruby"})
      new_book2.save()
      author1 = Author.new({:name => "Matz"})
      author1.save()
      author1.update({:book_ids => [new_book1.id, new_book2.id]})
      expect(author1.books).to(eq([new_book1, new_book2]))
    end
  end

  describe('#books') do
    it('returns all of the authors of a book') do
      new_book1 = Book.new({:name => "Learn Ruby"})
      new_book1.save()
      new_book2 = Book.new({:name => "More Ruby"})
      new_book2.save()
      author1 = Author.new({:name => "Matz"})
      author1.save()
      author1.update({:book_ids => [new_book1.id, new_book2.id]})
      expect(author1.books).to(eq([new_book1, new_book2]))
    end
  end
end
