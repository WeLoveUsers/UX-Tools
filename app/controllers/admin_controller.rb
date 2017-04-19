class AdminController < ApplicationController
  before_action :authenticate_admin_user

  # GET /admin
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
    @projects[:top_active] = {}
    ResponseAttrakDiff.group(:project).count.each do |project, count|
      @projects[:top_active][project] = count if !project.is_closed
    end
    ResponseSu.group(:project).count.each do |project, count|
      @projects[:top_active][project] = count if !project.is_closed
    end
    ResponseDeep.group(:project).count.each do |project, count|
      @projects[:top_active][project] = count if !project.is_closed
    end
    @projects[:top_active] = @projects[:top_active].to_a.sort_by{ |k, v| v }.reverse.take(5)
  end

  # GET /admin/project/1
  def project
    @project = Project.find(params[:id])
    @show_variability = false
    if cookies[:show_variability] && cookies[:show_variability].to_i > 0
      @show_variability = true
    end
    @ci_level = cookies[:ci_level] || '95%'
    @ci_level_hash_key = 'ci_' + @ci_level[0..1]
    @ci_level_hash_key = @ci_level_hash_key.to_sym

    filename = "[Questionnaire UX] - " + @project.product_name + "-" + @project.project_code + " (" + @project.questionnaire_id + ") - #{Date.today}"
    respond_to do |format|
      format.html
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xlsx"' }
    end
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
