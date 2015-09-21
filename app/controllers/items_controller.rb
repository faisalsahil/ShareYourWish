class ItemsController < ApplicationController
  before_filter :authenticate_user!
  caches_action :show
  
  def show 
    @item = Item.find_by_id params[:id] || not_found
    @package = Package.find_by_id params[:package_id] || not_found
    if request.xhr?
      render @item, :package => @package, :cart => false
    end
  end
  
end
