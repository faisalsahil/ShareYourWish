class FeedbacksController < InheritedResources::Base
  load_and_authorize_resource

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(params[:feedback])

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to :root, notice: "Your feedback was received - thanks for contacting us." }
        format.json { render json: @feedback, status: :created, location: @feedback }
      else
        format.html { render action: "new" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end
end
