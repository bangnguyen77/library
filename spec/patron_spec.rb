require "spec_helper"

describe(Patron) do
  describe('#name') do
    it('will return a Patron name') do
      new_patron = Patron.new({:name => "Patrick Pat"})
      expect(new_patron.name()).to(eq("Patrick Pat"))
    end
  end

  describe('#save') do
    it('will save a Patron to the database') do
      new_patron = Patron.new({:name => "Patrick Pat"})
      new_patron.save()
      expect(Patron.all()).to(eq([new_patron]))
    end
  end

  describe('.all') do
    it('will return a list of all Patrons') do
      new_patron1 = Patron.new({:name => "Patrick Pat"})
      new_patron1.save()
      expect(Patron.all()).to(eq([new_patron1]))
    end
  end

  describe("#id") do
    it('will return the id of a Patron') do
      new_patron = Patron.new({:name => "Patrick Pat", :id => 1})
      expect(new_patron.id()).to(eq(1))
    end
  end

  describe("#.find") do
    it('will return a patron by ID') do
      new_patron = Patron.new({:name => "Patrick Pat"})
      new_patron.save()
      expect(Patron.find(new_patron.id())).to(eq(new_patron))
    end
  end

  describe('#==') do
    it('will ensure the Patron objects are equal') do
      new_patron1 = Patron.new({:name => "Patrick Pat"})
      new_patron2 = Patron.new({:name => "Patrick Pat"})
      expect(new_patron1).to(eq(new_patron2))
    end
  end

  describe('#update') do
    it('will update an Patron object') do
      new_patron1 = Patron.new({:name => "Patrick Pat"})
      new_patron1.save()
      new_patron1.update({:name => 'Other Patron'})
      expect(new_patron1.name()).to(eq("Other Patron"))
    end
  end

  describe('#delete') do
    it('will delete a Patron') do
      new_patron1 = Patron.new({:name => "Patrick Pat"})
      new_patron1.save()
      new_patron2 = Patron.new({:name => "Patrick Pat"})
      new_patron2.save()
      new_patron1.delete()
      expect(Patron.all()).to(eq([new_patron2]))
    end
  end

end
