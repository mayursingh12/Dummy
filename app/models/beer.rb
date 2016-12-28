class Beer < ActiveRecord::Base

  # attr_accessor :slug

  belongs_to :beer_category

  extend FriendlyId
  friendly_id :name


  validates :name, presence: true

end
