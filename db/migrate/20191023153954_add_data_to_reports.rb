class AddDataToReports < ActiveRecord::Migration[6.0]
  def change
    # add_column :products, :part_number, :string
    # add_column :products, :price, :decimal
    add_column :reports, :avg_size, :float
    add_column :reports, :avg_price, :float
    add_column :reports, :avg_bed, :float
    add_column :reports, :avg_bath, :float
  end
end
