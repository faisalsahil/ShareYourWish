ActiveAdmin.register Feedback do
  
  controller do
    cache_sweeper :feedback_sweeper, :only => [ :create, :edit, :destroy ]
  end
  
  
end
