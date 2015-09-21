class UpdateEventSlugs < ActiveRecord::Migration
  def up
     @events = Event.find(:all)
     @events.each do |e|
        e.slug = e.page_alias.slug unless e.page_alias.nil?
        e.save
      end
       
  end

  def down
  end
end
