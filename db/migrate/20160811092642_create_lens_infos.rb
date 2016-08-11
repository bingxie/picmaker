class CreateLensInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :lens_infos do |t|
      t.string :raw_lens
      t.string :raw_lens_id
      t.string :custom_lens

      t.timestamps
    end
  end
end
