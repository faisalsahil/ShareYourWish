class ChildrenController < InheritedResources::Base
  
  # DELETE /guests/:guest_id/children/:id
  # DELETE /guests/:guest_id/children/:id.json
  def destroy
    @child = Child.find_by_id_and_guest_id(params[:id], params[:guest_id])

    respond_to do |format|
      if @child.destroy
        format.html { redirect_to :back }
        format.json { head :no_content }
      else
        format.html { redirect_to :back }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def reward_certificate
    @child = Child.find_by_id_and_guest_id(params[:id], params[:guest_id])
    @event = Event.find_by_id(params[:event_id])
    respond_to do |format|
      format.pdf do
        pdf = ChildRewardsCertificate.new(:template => ChildRewardsCertificate::TEMPLATE_PATH).to_pdf(@child,@event)
        send_data pdf, :filename => "guest_child_certificate.pdf", :type => 'application/pdf', :disposition => 'inline'
      end
    end
  end
  
end
