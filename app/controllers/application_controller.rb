class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :setup_app_updates

  def setup_app_updates
    @app_updates = Hash.new()
    @app_updates[:sus_dynamic_instructions_installed_at] = Date.new(2018,2,16)
  end

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def authenticate_admin_user
      if !self.authenticate_user! || !current_user.admin?
        redirect_to root_path, alert: 'Cette page est réservée aux administrateurs.'
        return false
      end
    end
end
