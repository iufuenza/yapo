# frozen_string_literal: true

require_relative '../command'
require_relative '../helpers/teletype'
require_relative '../helpers/commands'
require_relative '../helpers/validations'

module Yapo
  module Commands
    class Exec < Yapo::Command
      def initialize(command, options)
        @command = command
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        begin
          commands_helper = Yapo::Helpers::Commands.new
          validations_helper = Yapo::Helpers::Validations.new
          
          validations_helper.verify_version
          if @options[:prepend] && !@command.nil?
            commands = commands_helper.prepend_commands(@options[:prepend], @command)
          else
            commands = commands_helper.get_commands_for(@command)
          end
          
          if commands.nil?
            msg = "You must include an entry for #{@command} in .yapo.yml."
            raise Yapo::Helpers::CustomErrors::ValidationError.new(nil, msg)
          else
            Yapo::Helpers::Teletype.new.bash_commands(commands)
          end

          output.puts "OK"
        rescue Yapo::Helpers::CustomErrors::ValidationError
          output.puts "ERROR:ValidationError"
        rescue Yapo::Helpers::CustomErrors::SyntaxError
          output.puts "ERROR:SyntaxError"
        rescue Yapo::Helpers::CustomErrors::CommandError
          output.puts "ERROR:CommandError"
        end
      end
    end
  end
end
