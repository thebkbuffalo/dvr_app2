# add requires that didn't work automatically in Bundler.require
require 'zip'
require 'rack-flash'

# add generally useful requires
require 'yaml'

DB = Sequel.connect("postgres://localhost:5432/dvr_app_development")

Dir['./helpers/*.rb'].each { |helper| require helper }
Dir['./models/*.rb'].each { |model| require model }

require './controllers/application_controller'

Dir['./controllers/*.rb'].each { |controller| require controller }
