class Beer < ActiveRecord::Base

  # attr_accessor :slug

  extend FriendlyId
  friendly_id :name


  validates :name, presence: true

end
