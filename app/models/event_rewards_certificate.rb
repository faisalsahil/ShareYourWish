class EventRewardsCertificate < Prawn::Document
	TEMPLATE_PATH = Rails.root.join('app', 'assets', 'pdf', 'reward_certificate.pdf')
	FONT_PATH = Rails.root.join('app', 'assets', 'pdf')
	def to_pdf event
		move_down 230
		fill_color "e58f2b"
		font "#{FONT_PATH}/serifa_bt_bold.ttf"
		text "#{event.child_full_name}", :size => 40, :align => :center
		render
	end

end

