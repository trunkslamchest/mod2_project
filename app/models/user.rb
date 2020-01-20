class User < ApplicationRecord
	has_many :reports
	has_many :favorites
	has_many :properties

	has_secure_password

	PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x

	validates :password, format: {with: PASSWORD_FORMAT}
	validates :user_name, :email_address, :password, presence: true
	validates :email_address, uniqueness: true

end