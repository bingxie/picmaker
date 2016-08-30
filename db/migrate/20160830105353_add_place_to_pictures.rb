class AddPlaceToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :place, :string
  end
end
