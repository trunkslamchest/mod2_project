class User < ApplicationRecord

	has_many :reports
	has_many :favorites
	has_many :properties

	has_secure_password

end
