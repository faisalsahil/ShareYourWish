class Theme < ActiveRecord::Base
  self.primary_key = :code
  has_many :events, :foreign_key => :theme_code, :inverse_of => :theme
  attr_accessible :code, :is_premium, :cost, :friendly_name
  scope :premium, where(:is_premium => true)
  
  def icon
    ActionController::Base.helpers.asset_path("themes/#{self.code}-icon.jpg")
  end
  
  def preview
    ActionController::Base.helpers.asset_path("themes/#{self.code}-preview.jpg")
  end  
  
  def stylesheet
    ActionController::Base.helpers.asset_path("themes/#{self.code}-event-theme.css")
  end  
end
