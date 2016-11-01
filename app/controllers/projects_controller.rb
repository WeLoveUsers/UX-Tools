class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, except: [:respond]

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # GET /r/1
  def respond
    @project = Project.find_by uri_token: params[:uri_token]
    @showForm = false
    @form = ''

    if (params.has_key?(:step))
      case @project.questionnaire_id_clean
      when "attrakdiff"
        case params[:step]
        when "1"
          @showForm = true
          @form = @project.questionnaire_template + "_" + "step" + params[:step]
          @response = ResponseAttrakDiff.new
        else
        end
      when "system_usability_scale"
        case params[:step]
        when "1"
          @showForm = true
          @form = @project.questionnaire_template + "_" + "step" + params[:step]
          @response = ResponseSu.new
        else
        end
      end
    end
    render layout: "public_response"
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:questionnaire_id, :questionnaire_language, :product_type, :product_name, :project_code, :end_date, :uri_token, :user_id)
    end
end
