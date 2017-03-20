require 'spec_helper'

describe Vindicia::Response::Object do
  subject { Vindicia::Response::Object.new(nil) }

  it { is_expected.to be_a(Vindicia::Response::Base) }
  it { is_expected.to have_attr_accessor(:body) }

  it 'takes one arg to init' do
    expect(-> { Vindicia::Response::Object.new('anything') }).to_not raise_error
    expect(-> { Vindicia::Response::Object.new }).to raise_error(ArgumentError)
  end
end
