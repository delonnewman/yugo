require 'bundler/setup'
Bundler.require
require_relative '../lib/yugo'

run Yugo::Site.new
