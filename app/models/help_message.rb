class HelpMessage < ActiveRecord::Base
  validates :code, :text, :presence => true
  validates_uniqueness_of :code
  validates_format_of :code, :with => /^[0-9a-zA-Z\-_]+$/
  attr_accessible :code, :text
  attr_accessor :helper, :ajax_helper
  
  def helper
    "<%= help_text_caption '#{self.code}' %>"
  end
  
  def ajax_helper
    "<%= help_ajax_text_caption '#{self.code}' %>"
  end
end
