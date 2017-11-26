class Picture < ActiveRecord::Base


  # validates :artist, presence: true,
  # # validates :milliseconds, :bytes, numericality: {only_integer:true, greater_than: 0}
  # # validates :unit_price, numericality:{greater_than_or_eaqual_to: 0.0}
  # # valadates :name_must_be_titleized
  validates :artist, :url, presence: true
  validates :title, length: { maximum: 20, minimum: 3}
  validates :url, uniqueness: true

  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_five
    Picture.newest_first.limit(5)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

  def self.created_in_year(year)
    Picture.where("created_at >= ? and created_at <= ?", "#{year}-01-01", "#{year}-12-31")
  end

end
