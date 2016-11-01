class ResponseAttrakDiffsController < ApplicationController
  before_action :set_response_attrak_diff, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, except: [:create]

  # GET /response_attrak_diffs
  # GET /response_attrak_diffs.json
  def index
    @response_attrak_diffs = ResponseAttrakDiff.all
  end

  # GET /response_attrak_diffs/1
  # GET /response_attrak_diffs/1.json
  def show
  end

  # GET /response_attrak_diffs/new
  def new
    @response_attrak_diff = ResponseAttrakDiff.new
  end

  # GET /response_attrak_diffs/1/edit
  def edit
  end

  # POST /response_attrak_diffs
  # POST /response_attrak_diffs.json
  def create
    @response_attrak_diff = ResponseAttrakDiff.new(response_attrak_diff_params)
    @response_attrak_diff.project = Project.find_by uri_token: params[:uri_token]

    respond_to do |format|
      if @response_attrak_diff.save
        format.html { redirect_to @response_attrak_diff, notice: 'Response attrak diff was successfully created.' }
        format.json { render :show, status: :created, location: @response_attrak_diff }
      else
        format.html { render :new }
        format.json { render json: @response_attrak_diff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /response_attrak_diffs/1
  # PATCH/PUT /response_attrak_diffs/1.json
  def update
    respond_to do |format|
      if @response_attrak_diff.update(response_attrak_diff_params)
        format.html { redirect_to @response_attrak_diff, notice: 'Response attrak diff was successfully updated.' }
        format.json { render :show, status: :ok, location: @response_attrak_diff }
      else
        format.html { render :edit }
        format.json { render json: @response_attrak_diff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /response_attrak_diffs/1
  # DELETE /response_attrak_diffs/1.json
  def destroy
    @response_attrak_diff.destroy
    respond_to do |format|
      format.html { redirect_to response_attrak_diffs_url, notice: 'Response attrak diff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response_attrak_diff
      @response_attrak_diff = ResponseAttrakDiff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_attrak_diff_params
      params.require(:response_attrak_diff).permit(:ATT1, :ATT2, :ATT3, :ATT4, :ATT5, :ATT6, :ATT7, :QP1, :QP2, :QP3, :QP4, :QP5, :QP6, :QP7, :QHS1, :QHS2, :QHS3, :QHS4, :QHS5, :QHS6, :QHS7, :QHI1, :QHI2, :QHI3, :QHI4, :QHI5, :QHI6, :QHI7, :respondent_id, :project_id)
    end
end
