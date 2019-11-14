require 'bundler/setup'
Bundler.require

require 'erb'
require 'uri'
require 'logger'

require_relative 'yugo/runtime'
require_relative 'yugo/cfml'
require_relative 'yugo/site'
require_relative 'yugo/page'
require_relative 'yugo/database'
