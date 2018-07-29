require "yapo/version"
require "yapo/config/configurations"

module Yapo
  class << self
  	attr_accessor :configurations
  end

  self.configurations = Yapo::Config::Configurations.load
end
