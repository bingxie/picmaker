class AddIndexToLensInfos < ActiveRecord::Migration[5.0]
  def change
    add_index :lens_infos, [:raw_lens, :raw_lens_id], unique: true
  end
end
