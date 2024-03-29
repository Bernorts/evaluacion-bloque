# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bloque
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Mexico City'
    config.active_record.default_timezone = :local
    config.i18n.load_path += Dir[Rails.root.join('en', 'es', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es
    config.exceptions_app = routes
  end
end
