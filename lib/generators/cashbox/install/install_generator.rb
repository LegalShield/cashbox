require "rails/generators"
require "rails/generators/migration"

module Cashbox
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      desc "Add the migrations for Cashbox"
      def self.next_migration_number(path)
        next_migration_number = current_migration_number(path) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end

      def copy_migrations
        migration_template "./migrations/create_cashbox_logs.rb",
          "db/migrate/create_cashbox_logs.rb"
      end
    end
  end
end
