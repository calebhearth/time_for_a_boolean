require 'time_for_a_boolean/version'

module TimeForABoolean
  def time_for_a_boolean(attribute)
    define_method(attribute) { !send("#{attribute}_at").nil? }
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
