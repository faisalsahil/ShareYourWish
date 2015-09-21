class Comment < ActiveRecord::Base

  belongs_to :post
  
  validates :full_name,
              :presence => true
  
  validates :content,
            :presence => { :message => " of your comment is missing" }
                          
  validates :email,    
               :allow_blank => true,
              :format => { 
                 :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                 :message => "is not formatted properly"
                 },
                 :on => :create
  
end
