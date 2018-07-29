# frozen_string_literal: true

require_relative '../command'

module Yapo
  module Helpers
    module CustomErrors
      class ErrorMessage < Yapo::Command
        def initialize
        end

        def print(message)
          puts pastel.red(message)
        end
      end

      class ValidationError < StandardError
        attr_reader :original

        def initialize(exception = nil, msg)
          @original = exception
          ErrorMessage.new.print(message(msg))
        end

        def message(msg = nil)
          "#{msg}\n"
        end
      end

      class SyntaxError < StandardError
        attr_reader :original

        def initialize(exception = nil)
          @original = exception
          ErrorMessage.new.print(message)
        end

        def message
          "You have a syntax error in your .yapo.yml file.\n" \
          "#{@original}\n"
        end
      end

      class CommandError < RuntimeError
        attr_reader :params, :exit_status, :out, :err

        def initialize(command, result, *args)
          @command = command
          @params = *args
          @exit_status = result.exit_status
          @out = result.out
          @err = result.err
          ErrorMessage.new.print(message)
        end

        def message
          "The command you are tying to execute is not valid. Please verify it works in your terminal first.\n" \
          "Running \"#{@command}\" failed with exit status #{@exit_status}.\n" \
          "  params: #{@params}\n" \
          "  std out: #{@out}\n" \
          "  std err: #{@err}\n"
        end
      end

      class TimeoutError < RuntimeError
        attr_reader :params, :out, :err

        def initialize(command, timeout, result, *args)
          @command = command
          @params = *args
          @timeout = timeout
          @out = result.out
          @err = result.err
          super(message)
        end

        def message
          "Running \"#{@command}\" timed out after #{@timeout} seconds.\n" \
          "  params: #{@params}\n" \
          "  std out: #{@out}\n" \
          "  std err: #{@err}\n"
        end
      end
      
      class ErrorResult
        attr_reader :exit_status, :out, :err

        def initialize(exit_status, out, err)
          @exit_status = exit_status
          @out         = out
          @err         = err
        end
      end      
    end
  end
end
