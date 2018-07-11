require "active_support/core_ext/module/delegation"
require "active_support/core_ext/time/calculations"
require "active_model/type"
require "time_for_a_boolean/version"
require "time_for_a_boolean/railtie"

module TimeForABoolean
  def time_for_a_boolean(attribute, field="#{attribute}_at")
    define_method(attribute) do
      !send(field).nil? && send(field) <= -> { Time.current }.()
    end

    alias_method "#{attribute}?", attribute

    setter_attribute = "#{field}="
    define_method("#{attribute}=") do |value|
      if ActiveModel::Type::Boolean::FALSE_VALUES.include?(value)
        send(setter_attribute, nil)
      else
        send(setter_attribute, -> { Time.current }.())
      end
    end

    define_method("#{attribute}!") do
      send(setter_attribute, -> { Time.current }.())
    end
  end
end
