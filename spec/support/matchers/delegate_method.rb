RSpec::Matchers.define :delegate_method do |method|
  match do |object|
    @object = object

    return false unless @object.respond_to? @receiver

    result_double = double('result')
    receiver_double = double('receiver')
    allow(receiver_double).to receive(method).and_return(result_double)
    allow(@object).to receive(@receiver).and_return(receiver_double)

    @object.send(method) === result_double
  end

  description do
    "delegate #{method} to #{@receiver}"
  end

  failure_message do |text|
    "expected #{@object} to delegate #{method} to #{@receiver}"
  end

  failure_message_when_negated do |text|
    "expected #{@object} not to delegate #{method} to #{@receiver}"
  end

  chain(:to) { |receiver| @receiver = receiver }
end
