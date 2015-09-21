class Charity < ActiveRecord::Base
  acts_as_paranoid
  has_one :picture, :as => :imageable
  has_and_belongs_to_many :events
  belongs_to :lookup_charity_code, :inverse_of => :charities
  has_many :contributions, :inverse_of => :charity
  has_many :event_transaction_logs, :inverse_of => :charity

  attr_accessible :id, :name, :name_alias, :featured, :top_recommended, :description
  attr_accessible :city, :region, :website_url, :lookup_charity_code_id, :picture
  
  validates :name, :presence => true, :length => { :in => 2..45}

  scope :ordered_by_name, order(:name)
  scope :featured, where(:featured => true).ordered_by_name
  scope :top_recommended, where(:top_recommended => true).ordered_by_name
  scope :contributed, select('*, SUM(contributions.amount) as total_amount, COUNT(contributions.id) as guest_count').joins(:contributions).group("charities.id").ordered_by_name

  def self.search params, searchers, where = []
    searchers.each do |s|
      where << sprintf("%s LIKE '%s%%'", s, params[s]) if s.is_a?(Symbol) && params[s] && params[s].length
      if s.is_a?(Array)
        text = nil; s.each{ |searcher| text ||= params[searcher] if params[searcher] && params[searcher].length }
        c_or = []; s.each{ |searcher| c_or << sprintf("%s LIKE '%s%%'", searcher, text) } if text
        where << "(#{c_or.join(' OR ')})" if c_or.any?
      end
    end
    Charity.paginate(:page => params[:page], :per_page => params[:rows], :select => '`charities`.*, lookup_charity_codes.title', :joins => :lookup_charity_code, :conditions => where.join(' AND '))
  end

  def self.lookup_charity_codes
    self.joins(:lookup_charity_code).group.().select([:id,:region])
  end

  def self.regions
    self.group(:region).select([:id,:region])
  end
  
  def selected? charities = []
    charities = charities.to_a
    return false unless charities.present?
    return false unless self.persisted?
    charities.include? self
  end
end