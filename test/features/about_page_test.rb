require 'test_helper'

class AboutPageTest < FeatureTest
  test 'user can see About Page on about page' do
    visit '/pages/about'

    assert_content 'About Page'
  end
end
