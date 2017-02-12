class ResponseAttrakDiffAbridgedsController < ApplicationController

  # POST /response_attrak_diff_abridgeds
  def create
    @response_attrak_diff_abridged = ResponseAttrakDiffAbridged.new(response_attrak_diff_abridged_params)
    @response_attrak_diff_abridged.project = Project.find_by uri_token: params[:uri_token]
    @response_attrak_diff_abridged.respondent_id = request.remote_ip
    # Autre possibilité : ajouter un cookie

    respond_to do |format|
      if @response_attrak_diff_abridged.save
        format.html { redirect_to project_public_response_saved_path }
      else
        format.html { redirect_to project_public_respond_path(uri_token: @response_attrak_diff_abridged.project.uri_token, step: 1), alert: 'Des erreurs ont été détectées.' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_attrak_diff_abridged_params
      params.require(:response_attrak_diff_abridged).permit(:ATT2, :ATT5, :QP2, :QP3, :QP5, :QP6, :QHS2, :QHS5, :QHI3, :QHI4, :respondent_id, :project_id)
    end
end
