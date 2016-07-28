class AddExifColumnsToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :border_style, :string, null: false, default: 'black'
    add_column :pictures, :model, :string
    add_column :pictures, :lens, :string
    add_column :pictures, :f_number, :string
    add_column :pictures, :focal_length, :string
    add_column :pictures, :exposure_time, :string
    add_column :pictures, :iso, :string
  end
end
