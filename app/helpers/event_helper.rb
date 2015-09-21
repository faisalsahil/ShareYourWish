module EventHelper

  def hours_options event_time = nil
    hour = event_time ? Time.zone.parse(event_time).strftime("%I") : nil
    hours = ''
    %w[ 01 02 03 04 05 06 07 08 09 10 11 12 ].each do |h|
      selected = (hour == h) ? ' selected' : ''
      hours << "<option#{selected}>#{h}</option>"
    end
    hours.html_safe
  end

  def minutes_options event_time = nil
    min = event_time ? Time.zone.parse(event_time).strftime("%M") : nil
    minutes = ''
    %w[00 15 30 45].each do |m|
      selected = (min == m) ? ' selected' : ''
      minutes << "<option#{selected}>#{m}</option>"
    end
    minutes.html_safe
  end

  def noon_options event_time = nil
    noon = event_time ? Time.zone.parse(event_time).strftime("%p") : nil
    noons = ''
    %w[AM PM].each do |n|
      selected = (noon == n) ? ' selected' : ''
      noons << "<option#{selected}>#{n}</option>"
    end
    noons.html_safe
  end
  
  def charities_select_tag charities
    select_tag("charities", options_from_collection_for_select(charities, "id", "name"))
  end
  
  def guests_select_tag guests
    select_tag("charities", options_from_collection_for_select(guests, "id", "full_name"))
  end


end
