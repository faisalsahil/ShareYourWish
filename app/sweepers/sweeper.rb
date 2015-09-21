class Sweeper < ActionController::Caching::Sweeper

  def after_create(record)
    expire_cache_for(record)
  end

  def after_update(record)
    expire_cache_for(record)
  end

  def after_destroy(record)
    expire_cache_for(record)
  end

  private
  def expire_cache_for(record)
    expire_cache_for_cart record if record.is_a?(Cart)
    expire_cache_for_charity record if record.is_a?(Charity)
    expire_cache_for_event record if record.is_a?(Event)
    expire_cache_for_guest record if record.is_a?(Guest)
    expire_cache_for_item record if record.is_a?(Item)
    expire_cache_for_package record if record.is_a?(Package)
    expire_cache_for_picture record if record.is_a?(Picture)
  end

  def expire_cache_for_cart cart
    ActionController::Base.expire_page("/carts/#{cart.id}")
  end

  def expire_cache_for_charity charity
    ActionController::Base.expire_page("/charities")
    ActionController::Base.expire_page("/charity/#{charity.id}")
    expire_action(:controller => 'pictures', :action => :show, :id => charity.id)
  end

  def expire_cache_for_event event
    ActionController::Base.expire_page("/events/#{event.id}")
    ActionController::Base.expire_page("/pictures/#{event.id}/event")
  end

  def expire_cache_for_guest guest
    ActionController::Base.expire_page("/guests/#{guest.id}")
  end

  def expire_cache_for_item item
    ActionController::Base.expire_page("/items/#{item.id}")
  end

  def expire_cache_for_package package
     ActionController::Base.expire_page("/packages/#{package.id}")
     ActionController::Base.expire_page("/package/#{package.id}/items")
  end

  def expire_cache_for_picture picture
    ActionController::Base.expire_page("/pictures/#{picture.id}")
    expire_action(:controller => 'pictures', :action => :index)
  end

end
