class String
  def slug
    self.parameterize
  end
  
  def first_word
    word = self.split[0]
    word.nil? ? '' : word
  end
  
  def strip_tags
    ActionController::Base.helpers.strip_tags(self)
  end
  
  def sanitize options = {}
    ActionController::Base.helpers.sanitize(self, options)
  end
end