require 'spec_helper'

describe Vindicia::Model::Base do
  it { should be_a(Hashie::Trash) }
  it { should be_a(Hashie::Extensions::MergeInitializer) }
  it { should be_a(Hashie::Extensions::IgnoreUndeclared) }
  it { should be_a(Hashie::Extensions::IndifferentAccess) }
  it { should be_a(Hashie::Extensions::Dash::Coercion) }

  context '#object' do
    subject { Vindicia::Model::Base.new }

    it 'returns the base name of the class' do
      expect(subject.object).to eq('Base')
    end
  end
end
