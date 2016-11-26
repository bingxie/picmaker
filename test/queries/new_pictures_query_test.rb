require 'test_helper'

class NewPicturesQueryTest < ActiveSupport::TestCase
  test '.call' do
    approved_pictures = mock
    Picture.expects(:approved).returns(approved_pictures)
    approved_pictures.expects(:reorder).with(:created_at)

    NewPicturesQuery.call
  end
end
