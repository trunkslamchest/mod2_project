class AddUsertoProperty < ActiveRecord::Migration[6.0]
  def change
	add_reference :properties, :user, foreign_key: true
  end
end
