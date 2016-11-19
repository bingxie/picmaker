# == Schema Information
#
# Table name: pictures
#
#  id            :integer          not null, primary key
#  file_name     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  border_style  :string
#  model         :string
#  lens          :string
#  f_number      :string
#  focal_length  :string
#  exposure_time :string
#  iso           :string
#  lens_id       :string
#  user_id       :integer
#  place         :string
#

class Picture < ApplicationRecord
  acts_as_taggable

  include PictureAASM
  include PictureEXIF

  mount_uploader :file_name, ImageUploader

  belongs_to :user
  validates :user, presence: true
end
