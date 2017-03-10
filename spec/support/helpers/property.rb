RSpec::Matchers.define :have_property do |field|
  match do |instance|
    result = instance.respond_to?("#{field}=") && instance.respond_to?(field)
    result &&= @type == instance.class.key_coercions[field] unless @type.nil?
    result
  end

  chain :coercing_with do |type|
    @type = type
  end

  failure_message do |instance|
    "expected property for #{field} on #{instance}"
  end

  failure_message_when_negated do |instance|
    "expected property for #{field} not to be defined on #{instance}"
  end

  description do
    "have property named #{field}"
  end
end
