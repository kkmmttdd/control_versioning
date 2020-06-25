require "controllable_versioning/version"
require 'active_record'
require_relative './controllable_versioning/instance_methods'
require_relative './controllable_versioning/class_methods'

module ControllableVersioning
  include InstanceMethods

  def self.included(klass)
    klass.extend ClassMethods
  end
end
