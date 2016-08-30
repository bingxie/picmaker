# == Schema Information
#
# Table name: model_infos
#
#  id           :integer          not null, primary key
#  raw_model    :string
#  custom_model :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ModelInfo < ApplicationRecord
end
