require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
#require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.

require "./lib/action_view/helpers/verify_form_builder"

Bundler.require(*Rails.groups)


module VerifyFrontend
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    config.exceptions_app = self.routes

    #remove default rails headers as they are added by reverse proxy
    config.action_dispatch.default_headers.clear
    RouteTranslator.config do |config|
      config.hide_locale = true
      config.available_locales = [:en, :cy]
    end

    # by default rails wraps invalid inputs with <div class="field_with_errors">
    # we have our own way of styling errors, so we don't need this behaviour:
    config.action_view.field_error_proc = Proc.new { |html_tag| html_tag }

    # add in our custom form builder
    ActionView::Base.default_form_builder = VerifyFormBuilder::FormBuilder
  end
end
