class EventActivityLog < ActiveRecord::Base
	belongs_to :event, :inverse_of => :event_activity_logs
	TYPES = {1 => :status_changes, 2 => :guest_left_comment}
	MESSAGES = { 1 => "%s status change: %s", 
				2 => "%s has made an undisclosed contribution", 
				3 => "%s left comment: '%s...'", 
				4 => "%s has self-registered using the magic phrase",
				5 => "%s created new event %s",
				6 => "%s published the event %s"}

	attr_accessible :message, :is_internal, :type_of, :event_id, :event
	self.per_page = 8

	def self.create_status_changes guest, anonymous = false
		return false unless guest.is_a? Guest
		if anonymous
			self.create!(:message => sprintf(MESSAGES[2], guest.full_name), :event_id => guest.event.id, :is_internal => false, :type_of => 1)
		else	
			self.create!(:message => sprintf(MESSAGES[1], guest.full_name, guest.lookup_guests_status.friendly_text), :event_id => guest.event.id, :is_internal => false, :type_of => 1)
		end
	end			

	def self.new_magic_phrase_guest guest
		self.create!(:message => sprintf(MESSAGES[4], guest.full_name), :event_id => guest.event.id, :is_internal => false, :type_of => 1)
	end	

	def self.create_comment comment
		return false unless comment.is_a? Comment
		self.create(:message => sprintf(MESSAGES[3], comment.guest.full_name, comment.content ), :event_id => comment.commentable.id, :is_internal => false, :type_of => 2)
	end
	
	def self.new_event_created event
	  return false unless event.is_a? Event
	  self.create!(:message => sprintf(MESSAGES[5], event.user.full_name, event.title), :event_id => event.id, :is_internal => false, :type_of => 1)
	end
	
	def self.new_event_published event
    return false unless event.is_a? Event
    self.create!(:message => sprintf(MESSAGES[6], event.user.full_name, event.title), :event_id => event.id, :is_internal => false, :type_of => 1)
	end
end

