class EventActivityLogsController < ApplicationController
	before_filter :authenticate_user!
	layout false
	
	def index
		@event = Event.find(params[:event_id]) if params[:event_id]
		@event_activity_logs = @event ? @event.event_activity_logs.paginate(:page => params[:page]).order("created_at desc") : EventActivityLog.paginate(:page => params[:page]).order("created_at desc")
		respond_to do |format|
	      format.html
	    end
	end
end
