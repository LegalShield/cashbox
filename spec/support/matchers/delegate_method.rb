RSpec::Matchers.define :delegate_method do |method|
  match do |instance|
    @instance = instance

    return false unless @instance.respond_to? @receiver

    result_double = double('result')
    receiver_double = double('receiver')
    allow(receiver_double).to receive(method).and_return(result_double)
    allow(@instance).to receive(@receiver).and_return(receiver_double)

    @instance.send(method) === result_double
  end

  description do
    "delegate #{method} to #{@receiver}"
  end

  failure_message do |text|
    "expected #{@instance} to delegate #{method} to #{@receiver}"
  end

  failure_message_when_negated do |text|
    "expected #{@instance} not to delegate #{method} to #{@receiver}"
  end

  chain(:to) { |receiver| @receiver = receiver }
end
