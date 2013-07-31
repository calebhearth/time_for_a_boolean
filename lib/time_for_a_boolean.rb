require 'time_for_a_boolean/version'

module TimeForABoolean
  def time_for_a_boolean(attribute)
    define_method(attribute) { true }
    alias_method "#{attribute}?", attribute
  end
end
