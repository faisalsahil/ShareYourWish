module Validation
  module Event

    CHARITY_DONATION_PERCENTS = [0, 0.1, 0.25, 0.5, 0.75, 1.0]

    def self.included klass
      klass.validates :user, :presence => true

      klass.with_options :if => :published? do |event|
        add_event_details_validations(event)

        event.validates :child_dob, :presence => true, :date => {:before => Proc.new { Date.today }}, :on => :update

        event.validates_length_of :magic_phrase, :in => 2..255, :allow_nil => true, :allow_blank => true

        event.validates_length_of :page_content_one, :minimum => 2, :allow_nil => true, :allow_blank => true
        event.validates_length_of :page_content_two, :minimum => 2, :allow_nil => true, :allow_blank => true
        event.validates_length_of :page_content_three, :minimum => 2, :allow_nil => true, :allow_blank => true
        event.validates_length_of :page_content_four, :minimum => 2, :allow_nil => true, :allow_blank => true

        event.validates_inclusion_of :parental_consent_status, :in => ['notConfirmed', 'confirmed'], :allow_nil => true, :allow_blank => true
        event.validates :package_id, :presence => true, :numericality => {:only_integer => true}
        event.validates_inclusion_of :status, :in => ['in_progress', 'published', 'cancelled'], :allow_nil => true, :allow_blank => true
        event.validates_inclusion_of :invite_option, :in => ['syw-email', 'other-email', 'print'], :allow_nil => true, :allow_blank => true

        event.validates_length_of :charities, :in => 1..3, :if => :published?, :message => 'Please select one (1) to three (3) charities.'
      end

      #klass.validate on publish
      klass.validates :magic_phrase, :uniqueness => {:message => 'Magic Phrase must be unique.'}, :presence => {:message => 'Magic Phrase is blank or missing'}, :if => :published?
      klass.validates :page_content_one, :page_content_two, :page_content_three, :presence => {:message => 'Some required Event personalization fields are blank or missing'}, :if => :published?, :reduce => true

      klass.validates :event_sequence, :presence => true
      klass.validates_uniqueness_of :slug, :if => :title?, :on => :update

      klass.validates :theme_code, :presence => true
    end

    private

    def self.add_event_details_validations event
      event.validates :title, :presence => true, :length => {:in => 2..255}, :on => :update
      event.validates :host_name, :presence => true, :length => {:in => 2..255}, :on => :update
      event.validates :child_full_name, :presence => true, :length => {:in => 2..255}, :on => :update
      event.validates :child_pronoun, :presence => {:message => 'Please select a personalization option'}, :on => :update
      event.validates_inclusion_of :child_pronoun, :in => ['male', 'female', 'they'], :on => :update
      event.validates :event_date, :date => {:after => Proc.new { Date.today }, :before => Proc.new { Date.today + 1.year }, :message => "Event Date must be within the next one (1) year"}, :on => :update, :unless => :completed?
      event.validates :event_date, :presence => true, :on => :update
      event.validates_format_of :start_time, :with => /\d\d:\d\d:\d\d/, :on => :update, :allow_blank => true
      event.validates_format_of :end_time, :with => /\d\d:\d\d:\d\d/, :on => :update, :allow_blank => true
      event.validates :rsvp_by, :on => :update, :if => :event_date?, :date => {:before => Proc.new { |e| e.event_date }, :message => "RSVP date must be earlier than the Event date"}, :unless => :completed?
      event.validates :rsvp_by, :presence => true, :on => :update
      event.validates :charity_donation_percent, :presence => {:message => 'A charity Donation Level must be selected'}, :inclusion => {:in => CHARITY_DONATION_PERCENTS, :message => "Donation Level must be a fixed percentage"}, :on => :update, :reduce => true
    end

    def published?
      last_step? && completed?
    end

    def draft?
      !published?
    end

    def last_step?
      self.step_id.eql?(Step.last.id)
    end

    def completed?
      self.state.to_s == 'complete'
    end

    def event_date?
      self.event_date.present?
    end

  end
end
