class HelpMessagesController < InheritedResources::Base
  layout false
  def show
    @help_message = params[:code].present? ? HelpMessage.find_by_code(params[:code]) : HelpMessage.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @help_message }
    end
  end
end
