# frozen_string_literal: true

require_relative './custom_errors'

module Yapo
  module Helpers
    class Validations
      def verify_version
        version_match = Yapo.configurations['version'] == VERSION
        unless version_match
          msg = "You have an outdated version of Yapo. " \
          "Please verify that the version specified in .yapo.yml match with your gem version.\n" \
          "To check your gem version, run: yapo version"
          raise Yapo::Helpers::CustomErrors::ValidationError.new(nil, msg)
        end
      end
    end
  end
end
