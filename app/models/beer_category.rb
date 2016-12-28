class BeerCategory < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name

  has_many :beers

  validates :name, presence: true
  # validates :beer_category_id, presence: true

end
