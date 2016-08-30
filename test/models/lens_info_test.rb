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

require 'test_helper'

class LensInfoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
