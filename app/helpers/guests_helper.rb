module GuestsHelper
	def invite_url guest
		event_guest_invite_url(:slug => guest.event.slug, :guest_id => guest.id, :guest_access_token => guest.guest_access_token, :anchor => :top)
	end	
  def invite_path guest
    event_guest_invite_path(:slug => guest.event.slug, :guest_id => guest.id, :guest_access_token => guest.guest_access_token, :anchor => :top)
  end
end
