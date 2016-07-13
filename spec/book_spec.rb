require "spec_helper"

describe(Book) do
  describe('#name') do
    it('will return a Book name') do
      new_book = Book.new({:name => "Learn Ruby"})
      expect(new_book.name()).to(eq("Learn Ruby"))
    end
  end

  describe('#save') do
    it('will save a Book to the database') do
      new_book = Book.new({:name => "Learn Ruby"})
      new_book.save()
      expect(Book.all()).to(eq([new_book]))
    end
  end

  describe('.all') do
    it('will return a list of all Books') do
      new_book1 = Book.new({:name => "Learn Ruby"})
      new_book1.save()
      expect(Book.all()).to(eq([new_book1]))
    end
  end

  describe("#id") do
    it('will return the id of a Book') do
      new_book = Book.new({:name => "Learn Ruby", :id => 1})
      expect(new_book.id()).to(eq(1))
    end
  end

  describe("#.find") do
    it('will return a patron by ID') do
      new_book = Book.new({:name => "Learn Ruby"})
      new_book.save()
      expect(Book.find(new_book.id())).to(eq(new_book))
    end
  end

  describe('#==') do
    it('will ensure the Book objects are equal') do
      new_book1 = Book.new({:name => "Learn Ruby"})
      new_book2 = Book.new({:name => "Learn Ruby"})
      expect(new_book1).to(eq(new_book2))
    end
  end

  describe('#update') do
    it('will update an Book object') do
      new_book1 = Book.new({:name => "Learn Ruby"})
      new_book1.save()
      new_book1.update({:name => 'Other Book'})
      expect(new_book1.name()).to(eq("Other Book"))
    end
  end

  describe('#delete') do
    it('will delete a Book') do
      new_book1 = Book.new({:name => "Learn Ruby"})
      new_book1.save()
      new_book2 = Book.new({:name => "Learn Ruby"})
      new_book2.save()
      new_book1.delete()
      expect(Book.all()).to(eq([new_book2]))
    end
  end

end
