class AddLensIdToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :lens_id, :string
  end
end
