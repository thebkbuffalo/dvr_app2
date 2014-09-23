DB = Sequel.connect("postgres://localhost:5432/dvr_app_development")
Dir['./helpers/*.rb'].each { |helper| require helper }
Dir['./models/*.rb'].each { |model| require model }

# this wasn't auto-required above, for some reason...
require 'rack-flash'

require './controllers/application_controller'
Dir['./controllers/*.rb'].each { |controller| require controller }


