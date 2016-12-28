class BeerCategory < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name

  has_many :beers

  validates :name, presence: true

end
