ActiveAdmin.register Charity do

  controller do
    cache_sweeper :charity_sweeper, :only => [ :create, :edit, :destroy ]

    def create
      delete_image
      params[:charity][:picture] = Picture.create(params[:picture]) if params[:picture].is_a? Hash
      super
    end

    def update
      if params[:picture].is_a?(Hash) && params[:picture][:image]
        params[:charity][:picture] = Picture.create(params[:picture])
        delete_image
      elsif params[:charity][:delete_image]
        delete_image
      end
      super
    end

    def delete_image
      if params[:picture][:imageable_id]
        picture = Picture.find_by_imageable_id_and_imageable_type(params[:picture][:imageable_id], 'charity')
        picture.destroy if picture.is_a? Picture
      end
      params[:charity].delete(:delete_image) if params[:charity][:delete_image]
    end
  end

  show do |charity|
    attributes_table do
      row :name
      row :name_alias
      row :description
      row :city
      row :region
      row :website_url do
        link_to(charity.website_url, charity.website_url, :target => '_blank')
      end
      row :lookup_charity_code
      row :featured
      row :top_recommended
      row :image do
        image_tag(charity.picture.image.url, :width => 200)
      end if charity.picture
    end
    active_admin_comments
  end

  form :partial => "form"

end
