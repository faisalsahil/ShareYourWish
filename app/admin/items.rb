ActiveAdmin.register Item do

  controller do
    cache_sweeper :item_sweeper, :only => [ :create, :edit, :destroy ]

    def create
      delete_image
      params[:item][:picture] = Picture.create(params[:picture]) if params[:picture].is_a? Hash
      super
    end

    def update
      if params[:picture].is_a?(Hash) && params[:picture][:image]
        params[:item][:picture] = Picture.create(params[:picture])
        delete_image
      elsif params[:item][:delete_image]
        delete_image
      end
      super
    end

    def destroy 
      @item = Item.find params[:id]
      if @item.destroy
        flash[:notice] = "Item was successfully deleted."
        redirect_to :action => :index
      else
        flash[:error] = @item.errors.full_messages.join(',')
        redirect_to :action => :index
      end
    end

    def delete_image
      if params[:picture][:imageable_id]
        picture = Picture.find_by_imageable_id_and_imageable_type(params[:picture][:imageable_id], 'item')
        picture.destroy if picture.is_a? Picture
      end
      params[:item].delete(:delete_image) if params[:item][:delete_image]
    end
  end



  form :partial => "form"

  show do |item|
    attributes_table do
      row :name
      row :description
      row :cost
      row :taxable
      row :is_visible
      row :is_package_proxy
      row :sort_order
      row :image do
        image_tag(item.picture.image.url, :width => 200)
      end if item.picture
    end
    active_admin_comments
  end
end
