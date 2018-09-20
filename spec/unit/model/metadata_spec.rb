require 'spec_helper'

describe Cashbox::Metadata do
  it { is_expected.to be_a(Cashbox::Model) }

  it { is_expected.to have_property("vin:MandateFlag") }
  it { is_expected.to have_property("vin:MandateVersion") }
  it { is_expected.to have_property("vin:MandateBankName") }
  it { is_expected.to have_property("vin:MandateID") }
end
