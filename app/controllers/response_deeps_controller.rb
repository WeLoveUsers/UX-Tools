class ResponseDeepsController < ApplicationController

  # POST /response_deeps
  def create
    @response_deep = ResponseDeep.new(response_deep_params)
    @response_deep.project = Project.find_by uri_token: params[:uri_token]
    @response_deep.respondent_id = request.remote_ip
    # Autre possibilité : ajouter un cookie

    respond_to do |format|
      if @response_deep.save
        format.html { redirect_to project_public_response_saved_path }
      else
        format.html { redirect_to project_public_respond_path(uri_token: @response_deep.project.uri_token, step: 1), alert: 'Des erreurs ont été détectées.' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_deep_params
      params.require(:response_deep).permit(:Q1, :Q2, :Q3, :Q4, :Q5, :Q6, :Q7, :Q8, :Q9, :Q10, :Q11, :Q12, :Q13, :Q14, :Q15, :Q16, :Q17, :Q18, :Q19, :respondent_id, :project_id)
    end
end