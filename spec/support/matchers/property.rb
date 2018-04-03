RSpec::Matchers.define :have_property do |field|
  match do |instance|
    unless is_getter_defined = instance.respond_to?(field)
      @error_message = "expected getter for #{field} to be defined on #{instance}"
    end

    unless is_setter_defined = instance.respond_to?("#{field}=")
      @error_message = "expected setter for #{field} to be defined on #{instance}"
    end

    is_type_correct = true
    if @type
      unless is_type_correct = @type == instance.class.key_coercions[field]
        @error_message = "expected #{field} to be coerced to #{@type}"
      end
    end

    is_getter_defined && is_setter_defined && is_type_correct
  end

  chain :coercing_with do |type|
    @type = type
  end

  failure_message do |instance|
    @error_message
  end

  failure_message_when_negated do |instance|
    "did not #{@error_message}"
  end

  description do
    "have property named #{field}"
  end
end
