class App < ApplicationController
  # session NEW
  get('/') do
    if session[:current_user] # if there is a user set in the session
      if current_user # if there is a viewer with that id
        redirect to("/viewers/#{current_user.id}")
      else # the session is referring to a user who no longer exists!
        remove_current_user # clear the session
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
      set_current_user_as user
      redirect to("/viewers/#{current_user.id}")
    end
  end

  # session DELETE
  delete('/session') do
    remove_current_user
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

      # added a method to the helper!
      mail(subject: "New user update", body: "User '#{user.name}' created!")
      
      # add a nice message
      flash[:welcome] = 'Welcome to the DVR App!'

      # log in as the new user!
      set_current_user_as user

      # redirect to the user's show page
      redirect to("/viewers/#{current_user.id}")
    end
  end

  # viewers EDIT
  get('/viewers/:id/edit') do
    @viewer = Viewer.find(id: params[:id])
    render(:erb, :'viewers/edit')
  end

  # viewers UPDATE
  put('/viewers/:id') do
    viewer = Viewer.find(id: params[:id])
    viewer.update(name: params[:user_name])
    redirect to("/viewers/#{viewer.id}")
  end

  # viewers DELETE
  delete('/viewers/:id') do
    viewer = Viewer.find(id: params[:id])
    viewer.destroy

    # added a method to the helper!
    mail(subject: "User deleted update", body: "User '#{viewer.name}' deleted!")

    remove_current_user

    # leave a nice message
    flash[:error] = "Sorry to see you go... Come back soon!"

    redirect to('/')
  end
end