require 'active_record/connection_adapters/column'
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
      if ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(value)
        send("#{attribute}_at=", -> { DateTime.current }.())
      else
        send("#{attribute}_at=", nil)
      end
    end
  end
end
