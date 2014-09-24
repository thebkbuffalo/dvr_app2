module ApplicationHelper
  def link_to(title, path)
    '<a href="' + path + '">' + title + '</a>'
  end

  #################
  # mail helpers
  #################

  def mail(options)
    defaults = {
      to:      "admin@dvr_app.com", # replace with your address!
      subject: "Update",
      body:    "Something has happened to the DVR app..."
    }
    options = defaults.merge(options)
                      .merge({from: "updates@dvr_app.com"})
    Pony.mail(options)
  end

  #################
  # session helpers
  #################
  
  def set_current_user_as(user)
    # add a user to the session hash
    session[:current_user] = {id: user.id}

    # return that user as a Viewer instance
    current_user
  end

  def current_user
    @user ||= Viewer.find(id: session[:current_user][:id])
  end

  def remove_current_user
    # clear out the user from the session and the persisted variable
    @user, session[:current_user] = nil, nil
  end
end
