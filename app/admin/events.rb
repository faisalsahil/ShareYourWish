ActiveAdmin.register Event do
  menu :priority => 1, :label => "Event"
  
  member_action :report, :method => :get do
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html 
      format.csv { render cvs: @event }
    end
  end
  action_item :only => :report do
    link_to "Download Report", report_sywadmin_event_path(resource, :format => :csv), :target => "_new"
  end

  controller do
    cache_sweeper :event_sweeper, :only => [ :create, :edit, :destroy ]

    def create
      #params[:event][:pictures] = Picture.create(params[:picture]) if params[:picture].is_a? Hash
      super
    end

    def update
=begin
      if params[:picture].is_a? Hash && params[:picture][:image]
        params[:event][:pictures] = Picture.create(params[:picture])
      end
=end
      super
    end
  end

  index do
    column :id
    column "$ Report" do |i|
     link_to "report", report_sywadmin_event_path(i)
    end
    column "Dashboard" do |i|
         link_to "dashboard", event_dashboard_path(i.id), :target=>"_new"
    end 
    column (:title){|i| link_to i.title, event_path(i.id, :preview=>true), :target=>"_new" }
    column :status
    column :event_date
    column :child_full_name
    column :child_dob
    column :user
    column :state
    column :publicly_viewable
    column :gift_fund_locked
    column :donation_fund_locked
    column :parents_invited

    default_actions
  end

  form :partial => "form"

  show do |event|
    attributes_table do
      row :title
      row :event_date
      row :start_time
      row :end_time
      row :charity_donation_percent
      row :rsvp_by
      row :child_full_name
      row :child_pronoun
      row :child_dob
      row :location_name
      row :location_address
      row :parents_invited
      row :page_content_one
      row :page_content_two
      row :page_content_three
      row :page_content_four
      row :other_page_content
      row :parental_consent_status
      row :slug
      row :page_customization_hash
      row :magic_phrase
      row :icon_picture_id
      row :package_id
      row :status
      row :user_id
      row :step_id
      row :state
      row :publicly_viewable
      row :created_at
      row :updated_at

      row :images do |event|
        image_tag(event.pictures.first.image.url, :width => 200)
      end if event.pictures.present?


    end
    active_admin_comments
  end

end