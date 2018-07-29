# frozen_string_literal: true

require 'thor'

module Yapo
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'yapo version'
    def version
      require_relative 'version'
      puts "v#{Yapo::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'exec [COMMAND]', 'This command receives any bash script that you want to run in your project context.'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    method_option :prepend, aliases: '-p', type: :string,
                         desc: 'Prepend a bash command to your commands.'                         
    def exec(command, *args)
      if command.empty? || options[:help]
        invoke :help, ['exec']
      else
        require_relative 'commands/exec'
        Yapo::Commands::Exec.new(command, options).execute
      end
    end
  end
end
