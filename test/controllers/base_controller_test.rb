require 'test_helper'

class BaseController < ApplicationController
  def index
    head :ok
  end
end

class BaseControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    Rails.application.routes.draw do
      get 'base' => 'base#index'
    end
  end

  teardown do
    Rails.application.reload_routes!
  end

  test 'redirects if user is not logedin' do
    get '/base'

    assert_response :redirect
    assert_redirected_to 'http://www.example.com/'
  end

  test 'returns success if user is loggedin' do
    sign_in users(:one)

    get '/base'
    assert_response :success
  end
end
