RSpec::Matchers.define :have_attr_accessor do |field|
  match do |object|
    if object.respond_to?("#{field}=") && object.respond_to?(field)
      object.send("#{field}=", nil)
      object.instance_variable_defined?("@#{field}".to_sym)
    end
  end

  failure_message do |object|
    "expected attr_accessor for #{field} on #{object}"
  end

  failure_message_when_negated do |object|
    "expected attr_accessor for #{field} not to be defined on #{object}"
  end

  description do
    "have attribute accessor named #{field}"
  end
end

RSpec::Matchers.define :have_attr_reader do |field|
  match do |object|
    if object.respond_to?(field)
      object.instance_variable_set("@#{field}".to_sym, 'value') && object.send(field) == 'value'
    end
  end

  failure_message do |object|
    "expected attr_reader for #{field} on #{object}"
  end

  failure_message_when_negated do |object|
    "expected attr_reader for #{field} not to be defined on #{object}"
  end

  description do
    "have attribute reader named #{field}"
  end
end
