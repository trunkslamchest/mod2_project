class CreateComps < ActiveRecord::Migration[6.0]
  def change
    create_table :comps do |t|
      t.integer :zp_id
      t.integer :beds
      t.float :bath
      t.decimal :price
      t.belongs_to :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
