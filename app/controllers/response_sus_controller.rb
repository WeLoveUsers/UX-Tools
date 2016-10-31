class ResponseSusController < ApplicationController
  before_action :set_response_su, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, except: [:create]

  # GET /response_sus
  # GET /response_sus.json
  def index
    @response_sus = ResponseSu.all
  end

  # GET /response_sus/1
  # GET /response_sus/1.json
  def show
  end

  # GET /response_sus/new
  def new
    @response_su = ResponseSu.new
  end

  # GET /response_sus/1/edit
  def edit
  end

  # POST /response_sus
  # POST /response_sus.json
  def create
    @response_su = ResponseSu.new(response_su_params)
    @response_su.project = Project.find_by uri_token: params[:uri_token]

    respond_to do |format|
      if @response_su.save
        format.html { redirect_to @response_su, notice: 'Response su was successfully created.' }
        format.json { render :show, status: :created, location: @response_su }
      else
        format.html { render :new }
        format.json { render json: @response_su.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /response_sus/1
  # PATCH/PUT /response_sus/1.json
  def update
    respond_to do |format|
      if @response_su.update(response_su_params)
        format.html { redirect_to @response_su, notice: 'Response su was successfully updated.' }
        format.json { render :show, status: :ok, location: @response_su }
      else
        format.html { render :edit }
        format.json { render json: @response_su.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /response_sus/1
  # DELETE /response_sus/1.json
  def destroy
    @response_su.destroy
    respond_to do |format|
      format.html { redirect_to response_sus_url, notice: 'Response su was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response_su
      @response_su = ResponseSu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_su_params
      params.require(:response_su).permit(:Q1, :Q2, :Q3, :Q4, :Q5, :Q6, :Q7, :Q8, :Q9, :Q10, :respondent_id, :project_id)
    end
end
