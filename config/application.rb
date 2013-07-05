require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Bench
  class Application < Rails::Application
    config.middleware.use Rack::ContentLength
  end
end
