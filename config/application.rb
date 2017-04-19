require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PlayBall
  class Application < Rails::Application 
    config.assets.initialize_on_precompile = false  
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Match .scss, .sass or .less comments. Example // TODO make some notes
    config.annotations.register_extensions("scss", "sass", "less", "haml") do |annotation|
      /\/\/\s*(#{annotation}):?\s*(.*)$/
    end

  end
end
