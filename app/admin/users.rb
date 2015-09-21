ActiveAdmin.register User do
  menu :priority => 2, :label => "User"
  
  index do   
    column :id
    column (:email){|i| best_in_place i, :email, :type => :textarea, :path => [:sywadmin, i]}
    column (:full_name){|i| best_in_place i, :full_name, :type => :textarea, :path => [:sywadmin, i]}
    column (:user_name){|i| best_in_place i, :user_name, :type => :textarea, :path => [:sywadmin, i]}
    column (:is_under_age){|i| best_in_place i, :email, :type => :textarea, :path => [:sywadmin, i]}
    column (:language){|i| best_in_place i, :email, :type => :textarea, :path => [:sywadmin, i]}
    column :sign_in_count
    column :role
    column :last_sign_in_at
    
    default_actions
  end
  
  form do |f|
    f.inputs "Login" do
      f.input :email
      f.input :password, :hint => "Leave these field blank, or enter a new password to reset"
      f.input :password_confirmation
      f.input :role, :as => :select, :collection => User::ROLES
    end
    f.inputs "Details" do
      f.input :full_name
      f.input :user_name
      f.input :is_under_age
      f.input :language
    end

    f.buttons
  end 
end
