require "active_support"
require "active_support/core_ext/module/delegation"
require "active_support/core_ext/time/calculations"
require "active_model/type"
require "time_for_a_boolean/version"
require "time_for_a_boolean/railtie"

module TimeForABoolean
  def time_for_a_boolean(attribute, field=:"#{attribute}_at", scopes: false)
    define_method(attribute) do
      !send(field).nil? && send(field) <= -> { Time.current }.()
    end

    alias_method :"#{attribute}?", attribute

    setter_attribute = :"#{field}="
    define_method(:"#{attribute}=") do |value|
      if ActiveModel::Type::Boolean::FALSE_VALUES.include?(value)
        send(setter_attribute, nil)
      elsif send(field).nil?
        send(:"#{attribute}!")
      end
    end

    define_method(:"#{attribute}!") do
      send(setter_attribute, -> { Time.current }.())
    end

    if scopes && respond_to?(:where)
      singleton_class.instance_eval do
        define_method(:"#{attribute}") do
          where(field => ..Time.current)
        end

        define_method(:"not_#{attribute}") do
          where(field => [nil, Time.current...])
        end
      end
    end
  end
end
