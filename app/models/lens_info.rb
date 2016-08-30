# == Schema Information
#
# Table name: lens_infos
#
#  id          :integer          not null, primary key
#  raw_lens    :string
#  raw_lens_id :string
#  custom_lens :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LensInfo < ApplicationRecord
end
