require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Seamos
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :es
    Koala.config.api_version = 'v2.0'

    config.action_dispatch.default_headers = {
    'Access-Control-Allow-Origin' => 'http://seamos.mybluemix.net',
    'Access-Control-Request-Method' => %w{GET POST PUT OPTIONS}.join(",")
  }

  end
end
