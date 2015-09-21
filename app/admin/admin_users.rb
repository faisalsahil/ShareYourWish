ActiveAdmin.register AdminUser do
  menu :priority => 10, :label => "AdminUser"
   
  index do   
    column :id
    column (:email){|i| best_in_place i, :email, :type => :textarea, :path => [:sywadmin, i]}
    column :sign_in_count
    column :current_sign_in_at
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    
    default_actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.buttons
  end 
  
end
