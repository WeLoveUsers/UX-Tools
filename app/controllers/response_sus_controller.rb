class ResponseSusController < ApplicationController

  # POST /response_sus
  def create
    @response_su = ResponseSu.new(response_su_params)
    @response_su.project = Project.find_by uri_token: params[:uri_token]
    @response_su.respondent_id = request.remote_ip
    # Autre possibilité : ajouter un cookie

    respond_to do |format|
      if @response_su.save
        format.html { redirect_to project_public_response_saved_path }
      else
        format.html { redirect_to project_public_respond_path(uri_token: @response_su.project.uri_token, step: 1), alert: 'Des erreurs ont été détectées.' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_su_params
      params.require(:response_su).permit(:Q1, :Q2, :Q3, :Q4, :Q5, :Q6, :Q7, :Q8, :Q9, :Q10, :respondent_id, :project_id)
    end
end
