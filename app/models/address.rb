class Address < ActiveRecord::Base
  ATYPES = [:mailing, :shipping, :billing]
  belongs_to :user
  belongs_to :state
  validates :first_name, :last_name, :address_1, :city, :state_id, :postal_code, :presence => {:messsage => "Some required Address fields are missing"}
  validates_as_postal_code :postal_code, :country => "USA"
end
