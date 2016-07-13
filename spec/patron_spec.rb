require "spec_helper"

describe(Patron) do
  describe('#name') do
    it('will return a Patron name') do
      new_patron = Patron.new({:name => "Patrick Pat"})
      expect(new_patron.name()).to(eq("Patrick Pat"))
    end
  end



end
