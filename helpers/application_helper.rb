module ApplicationHelper
  def link_to(title, path)
    '<a href="' + path + '">' + title + '</a>'
  end

  # mail the administrator
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
end
