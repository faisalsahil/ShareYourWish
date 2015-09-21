ActiveAdmin.register Guest do

  controller do
    cache_sweeper :guest_sweeper, :only => [ :create, :edit, :destroy ]
    def destroy
      @guest = Guest.find params[:id]
      if @guest.destroy
        flash[:notice] = "Guest was successfully deleted."
        redirect_to :action => :index
      else
        flash[:error] = @guest.errors.full_messages.join(',')
        redirect_to :action => :index
      end
    end
  end

  index do
    column :id
    column "View Event as Guest"  do |guest|
      if guest.event.try(:slug)
        link_to 'View as guest', event_guest_invite_url(:slug => guest.event.slug, :guest_id => guest, :guest_access_token => guest.guest_access_token), :target => :_blank, :title => 'You need to log out to see this page as guest'
      else
      guest.guest_access_token
      end
    end
    column "Event" do |guest|
      if guest.event.try(:id)
        guest.event.title + ' [' + guest.event.id.to_s + ']'
      end
    end
    column :full_name
    column :email
    column :message
    column :attendance
    column (:lookup_guests_status){|i| i.lookup_guests_status.friendly_text}
    column :hidden
    column :braintree_customer_id
    column :guest_access_token
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :event
      f.input :user
      f.input :lookup_guests_status, :label => "Status", :as => :select, :collection => Hash[LookupGuestsStatus.all.map{|b| [b.friendly_text,b.id]}]
      f.input :full_name
      f.input :email
      f.input :guest_access_token
      f.input :hidden
      f.input :braintree_customer_id
      f.input :attendance, :as => :select, :collection => Guest::ATTENDANCES_TMP.keys
      f.input :message
    end

    f.buttons
  end
  
  show do |charity|
    attributes_table do
      row :event
      row :user
      row :lookup_guests_status do |g| 
        g.lookup_guests_status.friendly_text
      end
      row :full_name
      row :email
      row :guest_access_token
      row :hidden
      row :braintree_customer_id
      row :attendance
      row :message
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
