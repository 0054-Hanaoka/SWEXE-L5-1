require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module L5
  class Application < Rails::Application
    config.after_initialize do
      # 本番環境のみ
      if Rails.env.production?
        begin
          ActiveRecord::Base.connection
          ActiveRecord::Migrator.migrations_paths = [File.expand_path('db/migrate', __dir__)]
          ActiveRecord::MigrationContext.new(ActiveRecord::Migrator.migrations_paths).migrate
        rescue => e
          Rails.logger.error "Migration failed: #{e.message}"
        end
      end
    end
  end
end
