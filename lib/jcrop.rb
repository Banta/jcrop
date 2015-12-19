require 'jcrop/version'
require 'jcrop/engine'
require 'jcrop/is_jcropped'

module Jcrop
  # Load configuration from initializer
  def self.setup
    yield self
  end
end
