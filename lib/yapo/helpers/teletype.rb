# frozen_string_literal: true

require_relative './custom_errors'
require_relative '../command'

module Yapo
  module Helpers
    class Teletype < Yapo::Command
      def initialize
        @cmd = command(printer: :quiet)
      end

      def bash_commands(list)
        bash_command(list.join(' && '))
      end

      def bash_command(script, *args)
        begin
          puts pastel.green("Executing: #{script}")
          result = @cmd.run!(script, *args)
          cmd = TTY::Command.new

          if result.failure? && !result.exit_status.nil?
            raise Yapo::Helpers::CustomErrors::CommandError.new(script, result, *args)
          end
          result
        rescue StandardError => e
          result = Yapo::Helpers::CustomErrors::ErrorResult.new(1, "", e)
          raise Yapo::Helpers::CustomErrors::CommandError.new(script, result, *args)
        end
      end
    end
  end
end