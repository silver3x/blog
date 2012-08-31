require 'test_helper'

class AjaxControllerTest < ActionController::TestCase
  test "should get edit_comment" do
    get :edit_comment
    assert_response :success
  end

end
