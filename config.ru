require 'rubygems'
require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'] || 'development')

# this wasn't auto-required above, for some reason...
require 'rack-flash'

require './config/boot'

# map('/') { run RootController }

require './app'
run App