require_relative '../person'

describe 'Person' do
  before :each do
    @person = Person.new(20, 'Susan', true)
  end

  describe '#new' do

    it 'return the person object' do
      expect(@person).to be_an_instance_of Person
    end

    it 'has a set name Susan' do
      expect(@person.name).to eql 'Susan'
    end

    it 'should have parents permission' do
      expect(@person.parent_permission).to be true
    end

    it 'should not have parents permission' do
      nperson = Person.new(15, 'Susan', false)
      expect(nperson.parent_permission).to be_falsey
    end
  end

  describe 'Can use services' do
    context 'is minor' do
      it 'cannot use services' do
        person = Person.new(15, 'Mithi', false)
        expect(person.can_use_services?).to be false
      end
    end
    context 'is adult' do
      it 'can use services' do
        person = Person.new(18, 'Mithi')
        expect(person.can_use_services?).to be true
      end
    end
    context 'use method to validate age' do
      it 'is of age' do
        person = Person.new(18)
        expect(person.of_age?).to be true
      end
    end
    context 'use method to correct name' do
      it 'correct name' do
        person = Person.new(18, 'Thisus averylongname')
        expect(person.validate_name?).to eq('Thisus ave')
      end
    end
  end
end
