# frozen_string_literal: true
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tenjeo
  class Application < Rails::Application
    require 'darlingtonia'
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.active_job.queue_adapter = :sidekiq
  end
end
