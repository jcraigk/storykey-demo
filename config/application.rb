# frozen_string_literal: true
require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'

Bundler.require(*Rails.groups)

module StorykeyDemo
  class Application < Rails::Application
    config.load_defaults 7.0
    Rails.autoloaders.main.ignore(Rails.root.join('app/webpacker'))
    config.hosts.clear
  end
end
