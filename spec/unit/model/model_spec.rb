require 'spec_helper'

describe Cashbox::Model do
  it { is_expected.to be_a(Hashie::Trash) }
  it { is_expected.to be_a(Hashie::Extensions::MergeInitializer) }
  it { is_expected.to be_a(Hashie::Extensions::IgnoreUndeclared) }
  it { is_expected.to be_a(Hashie::Extensions::IndifferentAccess) }
  it { is_expected.to be_a(Hashie::Extensions::Dash::PropertyTranslation) }
  it { is_expected.to be_a(Hashie::Extensions::Dash::Coercion) }
  it { is_expected.to be_a(Hashie::Extensions::DeepMerge) }
end
