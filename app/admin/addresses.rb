ActiveAdmin.register Address do
  
  controller do
    cache_sweeper :address_sweeper, :only => [ :create, :edit, :destroy ]
  end
  
end
