ActiveAdmin.register Order do
  
  controller do
    cache_sweeper :order_sweeper, :only => [ :create, :edit, :destroy ]
  end
  
end
