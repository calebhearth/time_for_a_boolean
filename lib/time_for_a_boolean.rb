require "active_support/core_ext/module/delegation"
require "active_record/connection_adapters/column"
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
      if ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(value)
        send(setter_attribute, -> { Time.current }.())
      else
        send(setter_attribute, nil)
      end
    end
  end
end
