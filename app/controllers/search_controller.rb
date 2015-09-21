class SearchController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  def index
    not_found unless params[:q]
    @query = sanitize params[:q].strip
    @search_results = Event.search @query, params[:page]
  end
  
  def by_magic_phrase
    not_found unless params[:magic_phrase]
    magic_phrase = sanitize params[:magic_phrase].strip
    event = Event.find_by_magic_phrase(magic_phrase)
    if event.is_a?(Event)
      render :json => { :result => true, :url => visitor_entrance_event_path(event, :mp=>params[:magic_phrase]) }
    else
      render :json => { :result => false }
    end
  end
end
