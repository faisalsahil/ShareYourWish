class Step < ActiveRecord::Base
  has_many :events, :inverse_of => :step

  default_scope :order => '`order` ASC'
  validates :title, :presence => true, :length => { :in => 2..255 }
  validates :order, :presence => true, :inclusion => { :in => 0..99 }, :numericality => { :only_integer => true }
  attr_accessible :id, :locked_on_completion, :must_complete, :title, :order, :slug

  def next
    Step.where('`order` > ?', self.order).first
  end

  def previous
    Step.where('`order` < ?', self.order).last
  end

  def previous_must_complete
    Step.where('must_complete = ?', true).where('`order` < ?', self.order).last
  end

  # event_step.order must be less step.order
  def self.has_must_complete_before_event_step? event_step, step
    return nil unless event_step && step && event_step.order < step.order
    Step.where('`order` > ?', event_step.order).where('`order` < ?', step.order).where('must_complete = ?', true).any?
  end

  def must_complete?
    self.must_complete
  end

  def slug?
    self.slug.present?
  end
end
