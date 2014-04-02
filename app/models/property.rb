class Property < ActiveRecord::Base
	before_save :ensure_owner

	belongs_to :user

	validates :user_id, presence: true
	validates :name, presence: true, length: {minimum: 3, maximum: 120}
	validates :description, presence: true
	validates :beds, presence: true
	validates :baths, presence: true
	validates :rent, presence: true



	private
		def ensure_owner
			self.user.owner?
		end

end
