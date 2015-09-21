class PackagesController < ApplicationController
  before_filter :authenticate_user!
  caches_action :items

  def items
    @package = Package.find_by_id params[:id] || not_found
    if request.xhr?
      if @package.items.present? 
        render @package.items, :locals => {:package => @package, :cart => false}
      else
        render json: @package.errors, status: :unprocessable_entity
      end
    end
  end
  
end
