require_relative 'boot'

require 'rails/all'
require_relative '../lib/authentication/helper_methods.rb'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Indiereader
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    config.middleware.use Warden::Manager do |manager|  
      manager.failure_app = ->(env){ UnauthorizedController.action(:index).call(env) }
    end  

  end
end
