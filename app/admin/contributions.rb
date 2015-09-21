ActiveAdmin.register Contribution do
  
  controller do
    cache_sweeper :contribution_sweeper, :only => [ :create, :edit, :destroy ]
    
    def update
      @contribution = Contribution.find_by_id params[:id]
      if @contribution.update_attributes(params[:contribution])
        flash[:notice] = "Contribution was successfully updated."
        redirect_to :action => :index
      else
        flash[:error] = @contribution.errors.full_messages.join(',')
        redirect_to :action => :index
      end
    end
  end
  
  index do
    column :id
    column "Event" do |contribution|
        if contribution.event.try(:id)
          contribution.event.title + ' [' + contribution.event.id.to_s + ']'
        end
       end
    column "Guest Name" do |contribution|
        if contribution.guest.try(:id)
          contribution.guest.full_name + ' [' + contribution.guest.id.to_s + ']'
        end
       end
    column :charity_id
    column :amount
    column :anonymous
    column :pay_transaction_fee

    default_actions
  end
  
  form :partial => "form"
  
end
