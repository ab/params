require 'logger'
require 'yaml'

require 'bundler/setup'
require 'sinatra/base'

module Params
  def self.root_folder
    File.join(File.dirname(__FILE__), '..')
  end
end

require_relative './params/server'
