class Favorite < ApplicationRecord

	belongs_to :user
	belongs_to :property

	validates :user_id, :property_id, uniqueness: true

end
