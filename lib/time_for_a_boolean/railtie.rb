require "rails/railtie"

module TimeForABoolean
  class Railtie < ::Rails::Railtie
    initializer 'time_for_a_boolean' do
      ActiveSupport.on_load :active_record do
        extend TimeForABoolean
      end
    end
  end
end
