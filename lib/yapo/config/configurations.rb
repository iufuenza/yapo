require "yaml"

module Yapo
  module Config
    class Configurations
      YAPO_HOME = File.realpath(File.join(File.dirname(__FILE__), '..', '..'))
      DEFAULT_FILE = File.join(YAPO_HOME, 'yapo', 'config', 'default.yml')
      CURRENT_CONFIG_FILE   = File.expand_path(".yapo.yml", Dir.pwd)

      attr_reader :configurations

      def self.load
        new.load
      end

      def initialize
        @configurations = {}
      end

      def load
        if File.exist?(CURRENT_CONFIG_FILE)
          load_file(CURRENT_CONFIG_FILE)
        else
          load_file(DEFAULT_FILE)
        end

        @configurations
      end

      private

      def load_file(path)
        if File.exist?(path)
          @configurations = YAML.load_file(path)
        end
      end
    end
  end
end
