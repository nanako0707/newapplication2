require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)
module Newapplication2
  class Application < Rails::Application
    config.assets.initialize_on_precompile = false
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    I18n.enforce_available_locales = false
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.generators do |g|
      g.stylesheets false
      g.favascripts false
      g.assets false
      g.helper false
      g.test_framework false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
