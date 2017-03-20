require 'spec_helper'

describe Vindicia::Response::Collection do
  subject { Vindicia::Response::Collection.new('body') }

  it { is_expected.to be_a(Vindicia::Response::Base) }

  it { is_expected.to delegate_method(:each).to(:body) }
  it { is_expected.to be_an(Enumerable) }

  it { is_expected.not_to respond_to(:min) }
  it { is_expected.not_to respond_to(:max) }
  it { is_expected.not_to respond_to(:sort) }
end
