class Picture < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  belongs_to :imageable, :polymorphic => true
  
  has_attached_file(:image,
    :styles => {:tiny => '30x30>', :mini => '60x60>', :icon => '80x80>', :medium => "250x250>", :large => "600x600>"},
    :default_url => '/assets/missing_:style.png'
  )

  # validates_attachment_content_type :image, :content_type => [ 'image/jpeg', 'image/gif', 'image/png' ], :message => 'Sorry that is not a supported image type.'
  # EP: pwoloszun change test from content_type to file name... but will this work for images from Mac w/o dot notation?
  validates_format_of :image_file_name, :with => /\.jpe?g|png|gif$/i, :message => 'Sorry that is not a supported image type.'
  validates_attachment :image, :presence => true, :size => {:in => 0..6.megabytes}

  validates_attachment_presence :image
  clear_files :image
  attr_accessible(:id, :picture, :imageable_id, :imageable_type, :image, :image_file_name, :layout_section, :image_remote_url,
    :image_content_type, :image_file_size, :image_updated_at, :sort_order, :layout_slot, :delete_image
  )
  attr_reader :image_remote_url
  
  before_post_process :skip_if_invalid
  def skip_if_invalid
     return false unless self.valid?
   end
   
  def to_jq_upload
    {
      "id" => id,
      "name" => image_file_name,
      "size" => image.size,
      "url" => image.url,
      "layout_slot" => layout_slot,
      "thumbnail_url" => image.url(:icon),
      "delete_url" => picture_path(:id => id, :imageable_id => imageable_id),
      "delete_type" => "DELETE"
    }
  end

  def image_remote_url=(url_value)
    return nil unless url_value.to_s.length > 0
    self.image = URI.parse(url_value)
    @image_remote_url = url_value
  end

end
