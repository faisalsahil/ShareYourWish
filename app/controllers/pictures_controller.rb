class PicturesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :assign_event!

  def index
    @pictures = @event.pictures
    render :json => jq_upload_json_for(@pictures)
  end

  def create
    @picture = Picture.new(params[:picture])
    respond_to do |format|
      if @picture.save
        @event.update_attributes(:icon_picture_id => @picture.id) if params[:event] && params[:event][:icon_picture_id] == '1'
        json = jq_upload_json_for([@picture])
        format.html { render :json => json, :content_type => 'text/html', :layout => false }
        format.json { render :json => json }
      else
        json = jq_upload_error_for(@picture)
        format.html { render :json => json, :content_type => 'text/html', :layout => false }
        format.json { render :json => json }
      end
    end
  rescue OpenURI::HTTPError, TypeError
    render :json => {:files => [{:error => "This URL does not exist."}]}.to_json
  end

  def destroy
    @picture = @event.pictures.find(params[:id])
    @picture.destroy
    render :json => true
  end

  private

  def assign_event!
    event_id = params[:imageable_id]
    @event = current_user.events.find(event_id) || raise("Current User does not have Event with id: #{event_id}")
  end

  def jq_upload_json_for pictures
    {:files => pictures.map(&:to_jq_upload)}.to_json
  end

  def jq_upload_error_for picture
    {:files => [:error => picture.errors.full_messages.join(", ")]}.to_json
  end

end
