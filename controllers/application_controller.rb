class ApplicationController < Sinatra::Base

  # we set this variable to the root of our project
  # whenever the application file(s) (ie, controllers)
  # are not in the root of the project, OR they inherit
  # from a controller that is not in the root of the project
  set :app_file,  File.expand_path(File.dirname(__FILE__), '../')

  helpers ApplicationHelper
  
  enable :method_override
  enable :sessions
  set :session_secret, 'super secret'

  configure :test, :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  # add a flash has to our website! https://github.com/treeder/rack-flash
  use Rack::Flash
end
