class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zp_id

      t.timestamps
    end
  end
end
