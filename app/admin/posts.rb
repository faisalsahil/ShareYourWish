ActiveAdmin.register Post do
  filter :id
  filter :title
  filter :content
  filter :posts_category
  
  controller do
    cache_sweeper :post_sweeper, :only => [ :create, :edit, :destroy ]
    def create
      params[:post].delete(:tag_ids) if params[:post][:tag_ids].present?
      super
    end
    def update
      params[:post].delete(:tag_ids) if params[:post][:tag_ids].present?
      super
    end
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :content, :input_html => { :class => :editor }
      f.input :author
      f.input :posts_category
    end
    f.inputs 'Tags' do
      f.input :tag_list
      f.input :tags, :label => "All tags", :as => :select, :input_html => { :id => :posts_tags_select }
    end
      
    f.buttons
  end
  
  index do
    column :id
    column :title
    column :content
    column :author
    column :posts_category
    column :tag_list
    
    default_actions
  end
  
  show do |item|
    attributes_table do
      row :id
      row :title
      row :content
      row :author
      row :posts_category
      row :tag_list
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  
end
