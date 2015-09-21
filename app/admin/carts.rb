ActiveAdmin.register Cart do
  
  controller do
    cache_sweeper :cart_sweeper, :only => [ :create, :edit, :destroy ]
  end
  
end
