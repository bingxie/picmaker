class AddDimensionsToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :dimensions, :string
  end
end
