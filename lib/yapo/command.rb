# frozen_string_literal: true

require 'forwardable'

module Yapo
  class Command
    extend Forwardable

    def_delegators :command, :run
    def_delegators :pastel

    # Execute this command
    #
    # @api public
    def execute(*)
      raise(
        NotImplementedError,
        "#{self.class}##{__method__} must be implemented"
      )
    end

    # The external commands runner
    def command(**options)
      require 'tty-command'
      TTY::Command.new(options)
    end

    # The output styler
    def pastel(**options)
      require 'pastel'
      Pastel.new(options)
    end

    # File manipulation utility methods
    def generator
      require 'tty-file'
      TTY::File
    end

    # Terminal platform and OS properties
    def platform
      require 'tty-platform'
      TTY::Platform.new
    end

    # The interactive prompt
    def prompt(**options)
      require 'tty-prompt'
      TTY::Prompt.new(options)
    end

    # Get terminal screen properties
    def screen
      require 'tty-screen'
      TTY::Screen
    end

    # The unix which utility
    def which(*args)
      require 'tty-which'
      TTY::Which.which(*args)
    end

    # Check if executable exists
    def exec_exist?(*args)
      require 'tty-which'
      TTY::Which.exist?(*args)
    end
  end
end
