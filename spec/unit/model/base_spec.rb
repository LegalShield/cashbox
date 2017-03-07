require 'spec_helper'

describe Vindicia::Model::Base do
  context '#object' do
    subject { Vindicia::Model::Base.new }

    it 'returns the base name of the class' do
      expect(subject.object).to eq('Base')
    end
  end

  context '#initialize' do
    it 'initializes the object and sets instance vars' do
      allow_any_instance_of(Vindicia::Model::Base).to receive(:update_attributes)
      model = Vindicia::Model::Base.new({ hey: :there })
      expect(model).to have_received(:update_attributes)
    end
  end

  context '#update_attributes' do
    before do
      subject.update_attributes({
        first_name: 'Jon',
        last_name: 'Storer',
      })
    end

    it 'sets instance variables on the class' do
      expect(subject.instance_variable_get('@first_name')).to eql('Jon')
      expect(subject.instance_variable_get('@last_name')).to eql('Storer')
    end
  end
end
