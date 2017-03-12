require 'spec_helper'

describe Vindicia::Model::Base do
  it { is_expected.to be_a(Hashie::Trash) }
  it { is_expected.to be_a(Hashie::Extensions::MergeInitializer) }
  it { is_expected.to be_a(Hashie::Extensions::IgnoreUndeclared) }
  it { is_expected.to be_a(Hashie::Extensions::IndifferentAccess) }
  it { is_expected.to be_a(Hashie::Extensions::Dash::Coercion) }
  its(:object) { is_expected.to eql('Base') }

end
