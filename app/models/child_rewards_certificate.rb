class ChildRewardsCertificate < Prawn::Document
	TEMPLATE_PATH = Rails.root.join('app', 'assets', 'pdf', 'guest_child_certificate.pdf')
	FONT_PATH = Rails.root.join('app', 'assets', 'pdf')
	def to_pdf child, event
		fill_color "4FA9BE"
		font "#{FONT_PATH}/robot.ttf"
		text_box "#{child.name},", :size => 24, :kerning => true, :at => [110, 544]
		text_box "#{event.child_full_name}", :size => 24, :kerning => true, :at => [360, 440]
		render
	end

end


