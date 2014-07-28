require 'rails'
require 'time_for_a_boolean/version'
require 'time_for_a_boolean/railtie'

module TimeForABoolean
  def time_for_a_boolean(attribute)
    define_method(attribute) do
      !send("#{attribute}_at").nil? &&
        send("#{attribute}_at") <= -> { DateTime.now }.()
    end
    alias_method "#{attribute}?", attribute
    define_method("#{attribute}=") do |value|
      if value
        send("#{attribute}_at=", -> { DateTime.now }.())
      else
        send("#{attribute}_at=", nil)
      end
    end
  end
end
