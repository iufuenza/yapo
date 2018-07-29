# frozen_string_literal: true

require_relative './custom_errors'

module Yapo
  module Helpers
    class Commands
      def get_commands_for(command_name)
        begin
          Yapo.configurations['commands'][command_name] unless 
                                        Yapo.configurations['commands'][command_name].nil?
        rescue StandardError => e
          raise Yapo::Helpers::CustomErrors::SyntaxError, e
        end
      end

      def prepend_commands(prepend, command_name)
        begin
          commands = get_commands_for(command_name)
          prepend_cmd = Yapo.configurations['prepends'][prepend]['command'].first unless 
                                        Yapo.configurations['prepends'].nil? || 
                                        Yapo.configurations['prepends'][prepend].nil?
          commands.first.map { |e| "#{prepend_cmd.first} #{e}" }
        rescue StandardError => e
          raise Yapo::Helpers::CustomErrors::SyntaxError, e
        end
      end
    end
  end
end
