class AddAdminUser < ActiveRecord::Migration
  def up
          AdminUser.create!(:email => 'eric@veryinventive.com', :password => '123456', :password_confirmation => '123456')
  end

  def down
  end
end
