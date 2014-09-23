class App < ApplicationController
  # session NEW
  get('/') do
    if session[:current_user] # if there is a user set in the session
      if Viewer.find(id: session[:current_user][:id]) # if there is a viewer with that id
        redirect to("/viewers/#{session[:current_user][:id]}")
      else # the session is referring to a user who no longer exists!
        session[:current_user] = nil # clear the session
        render(:erb, :'session/new')
      end
    else
      render(:erb, :'session/new')
    end
  end

  # session CREATE
  post('/session') do
    # look up the user by the name in params
    user = Viewer.find(name: params[:user_name])
    if user.nil? # if there was no user found with that name
      # flash is like session, except it only lasts for ONE MORE request!
      flash[:error] = "No user found with that name!"
      redirect to('/')
    else
      # add a user to the session hash
      current_user_id = user.id
      session[:current_user]  = {id: current_user_id}
      redirect to("/viewers/#{current_user_id}")
    end
  end

  # session DELETE
  delete('/session') do
    # clear out the user from the session
    session[:current_user] = nil
    redirect to('/')
  end

  # viewers NEW (must come before the id matcher below!)
  get('/viewers/new') do
    render(:erb, :'viewers/new')
  end

  # viewers SHOW
  get('/viewers/:id') do
    @viewer = Viewer.find(id: params[:id])
    render(:erb, :'viewers/show')
  end

  # viewers CREATE
  post('/viewers') do
    user = Viewer.find(name: params[:user_name])
    if user # if a user with this name already exists!
      flash[:error] = "This user already exists!"
      redirect to('/viewers/new')
    else
      # create the new user!
      user = Viewer.create(name: params[:user_name])
      
      # add a nice message
      flash[:welcome] = 'Welcome to the DVR App!'

      # log in as the new user!
      current_user_id = user.id
      session[:current_user]  = {id: current_user_id}

      # redirect to the user's show page
      redirect to("/viewers/#{current_user_id}")
    end
  end
end