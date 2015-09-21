ActiveAdmin.register Subscriber do
  
  controller do
    cache_sweeper :subscriber_sweeper, :only => [ :create, :edit, :destroy ]
  end
  
  index do
    column :id
    column :full_name
    column :email
    column :comment
    column :displayme

    default_actions
  end
  
  
end
