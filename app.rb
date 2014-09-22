class App < ApplicationController
  get('/') do
    render(:erb, :index)
  end
end