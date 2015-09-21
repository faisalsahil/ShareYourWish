ActiveAdmin.register Picture do
  menu :priority => 5, :label => "Picture"

  controller do
    cache_sweeper :picture_sweeper, :only => [ :create, :edit, :destroy ]
  end

  index do
    column :id
    column :imageable_id
    column :imageable_type
    column :sort_order
    column :layout_section
    column :layout_slot
    column :image_file_name

    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :imageable_id
      f.input :imageable_type, :as => :select, :collection => [:event, :package, :charity, :item]
      f.input :sort_order, :as => :select, :collection => [0,1,2,3,4,5,6,7,8,9,10]
      f.input :layout_section, :as => :select, :collection => [[:section_1,1],[:section_2,2],[:section_1,3]]
      f.input :layout_slot, :as => :select, :collection => [0,1,2,3,4,5]
      f.input :image, :as => :file
      f.input :delete_image, :as=>:boolean, :required => false, :label => 'Remove image'
    end

    f.buttons
  end

  show do |picture|
    attributes_table do
      row :id
      # row :imageable_id
      row :imageable_type
      row :sort_order
      row :layout_section
      row :layout_slot
      row :image_file_name
      row :image do
        image_tag(picture.image.url, :width => 200)
      end
    end
    active_admin_comments
  end
end