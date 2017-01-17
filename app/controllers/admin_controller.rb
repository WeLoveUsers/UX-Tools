class AdminController < ApplicationController
  before_action :authenticate_admin_user

  def index
    @count = {}
    @count[:users] = User.count(:all)
    @count[:projects] = Project.count(:all)
    @count[:responses] = ResponseDeep.count(:all) + ResponseSu.count(:all) + ResponseAttrakDiff.count(:all)
    @users = {}
    @users[:active] = User.order(:current_sign_in_at).last(5)
    @users[:new] = User.order(:created_at).last(5)
    @projects = {}
    @projects[:new] = Project.order(:created_at).last(5)
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
