class CreateGuestAccessTokens < ActiveRecord::Migration
  def up
     guests = Guest.find(:all)
     
     guests.each do |g|
        g.create_guest_access_token 
        g.save 
     end
     
  end

  def down
  end
end
