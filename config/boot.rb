DB = Sequel.connect("postgres://localhost:5432/dvr_app2_development")
Dir['./helpers/*.rb'].each { |helper| require helper }
Dir['./models/*.rb'].each { |model| require model }
require 'rack-flash'
require './controllers/application_controller'
Dir['./controllers/*.rb'].each { |controller| require controller }
