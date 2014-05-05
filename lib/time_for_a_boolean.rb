require 'rails'
require 'active_record'
require 'time_for_a_boolean/version'
require 'time_for_a_boolean/railtie'

module TimeForABoolean
  def time_for_a_boolean(attribute)
    define_method(attribute) do
      !send("#{attribute}_at").nil? &&
        send("#{attribute}_at") <= -> { DateTime.current }.()
    end
    alias_method "#{attribute}?", attribute
    define_method("#{attribute}=") do |value|
      if self.class.value_for_boolean(value)
        send("#{attribute}_at=", -> { DateTime.current }.())
      else
        send("#{attribute}_at=", nil)
      end
    end
  end

  def value_for_boolean(value)
    ActiveRecord::ConnectionAdapters::Column.value_to_boolean(value)
  end
end
