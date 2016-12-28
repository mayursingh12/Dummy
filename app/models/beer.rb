class Beer < ActiveRecord::Base

  belongs_to :beer_category

  extend FriendlyId
  friendly_id :name

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :pair_with, presence: true
  validates :beer_category_id, presence: true

end
