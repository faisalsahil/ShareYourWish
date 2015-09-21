ActiveAdmin.register Package do

  controller do
    cache_sweeper :package_sweeper, :only => [ :create, :edit, :destroy ]

    def create
      delete_image
      params[:package][:picture] = Picture.create(params[:picture]) if params[:picture].is_a? Hash
      super
    end

    def update
      if params[:picture].is_a?(Hash) && params[:picture][:image]
        params[:package][:picture] = Picture.create(params[:picture])
        delete_image
      elsif params[:package][:delete_image]
        delete_image
      end
      super
    end

    def delete_image
      if params[:picture][:imageable_id]
        picture = Picture.find_by_imageable_id_and_imageable_type(params[:picture][:imageable_id], 'package')
        picture.destroy if picture.is_a? Picture
      end
      params[:package].delete(:delete_image) if params[:package][:delete_image]
    end
  end

  form :partial => "form"

  show do |package|
    attributes_table do
      row :name
      row :description
      row :cost
      row :image do
        image_tag(package.picture.image.url, :width => 200)
      end if package.picture
    end
    active_admin_comments
  end
end
