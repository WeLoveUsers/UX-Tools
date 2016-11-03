class ResponseAttrakDiffsController < ApplicationController

  # POST /response_attrak_diffs
  def create
    @response_attrak_diff = ResponseAttrakDiff.new(response_attrak_diff_params)
    @response_attrak_diff.project = Project.find_by uri_token: params[:uri_token]
    @response_attrak_diff.respondent_id = request.remote_ip
    # Autre possibilité : ajouter un cookie

    respond_to do |format|
      if @response_attrak_diff.save
        format.html { redirect_to project_public_response_saved_path }
      else
        format.html { redirect_to project_public_respond_path(uri_token: @response_attrak_diff.project.uri_token, step: 1), alert: 'Des erreurs ont été détectées.' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_attrak_diff_params
      params.require(:response_attrak_diff).permit(:ATT1, :ATT2, :ATT3, :ATT4, :ATT5, :ATT6, :ATT7, :QP1, :QP2, :QP3, :QP4, :QP5, :QP6, :QP7, :QHS1, :QHS2, :QHS3, :QHS4, :QHS5, :QHS6, :QHS7, :QHI1, :QHI2, :QHI3, :QHI4, :QHI5, :QHI6, :QHI7, :respondent_id, :project_id)
    end
end
