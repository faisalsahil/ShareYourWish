# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.shareyourwish.com"

SitemapGenerator::Sitemap.create do

  
  Page.find_each do |page|
    add "/#{page.slug}", :lastmod => page.updated_at, :changefreq => 'monthly'
  end
  
  add feed_path
  add new_user_session_path
  add new_user_registration_path
  
  Event.find_each do |event|
    add event_path(event.slug), :lastmod => event.updated_at, :changefreq => 'monthly'
  end

end

