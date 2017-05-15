class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #before_action :authenticate_user!

  def save_project_response_tracking(project)
    cookies.permanent['responded_to_project_' + project.id.to_s] = 1
  end

  def has_already_responded(project)
    has_already_responded = false
    if cookies.permanent['responded_to_project_' + project.id.to_s] && cookies.permanent['responded_to_project_' + project.id.to_s].to_i > 0
      has_already_responded = true
    end
    return has_already_responded
  end
end
