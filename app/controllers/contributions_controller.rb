class ContributionsController < ApplicationController
  load_and_authorize_resource
  layout false

  def create
    @contribution = Contribution.new(params[:contribution])
    respond_to do |format|
      if @contribution.save!
        format.html { redirect_to :back, notice: 'Thanks! Your contribution has been accepted.' }
        format.json { render json: {:result => true, :contribution => @contribution, :payment => @contribution.payment}, status: :created }
      else
        format.html { redirect_to :back, status: 307, notice: "Error, contribution was not created: #{@contribution.errors.full_messages.join(', ')}  #{@contribution.payment.errors.full_messages.join(',')}" }
        format.json { render json: {:result => false, :errors => { :contribution_errors => @contribution.errors, :payment_errors => @contribution.payment.errors }}, status: :ok }
      end
    end
  end
end
