class Subscriber < ActiveRecord::Base

   validates :full_name,
               :presence => true
   
   validates :email,   
               :presence => true,   
               :uniqueness => true,   
               :format => { 
                  :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                  :message => "is not formatted properly"
                  },
                  :on => :create
                  
            
end
