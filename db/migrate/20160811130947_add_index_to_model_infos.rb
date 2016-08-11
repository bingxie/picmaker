class AddIndexToModelInfos < ActiveRecord::Migration[5.0]
  def change
    add_index :model_infos, :raw_model, unique: true
  end
end
