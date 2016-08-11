class CreateModelInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :model_infos do |t|
      t.string :raw_model
      t.string :custom_model

      t.timestamps
    end
  end
end
