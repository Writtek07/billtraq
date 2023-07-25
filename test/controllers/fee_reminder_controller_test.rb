require 'test_helper'

class FeeReminderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fee_reminder_index_url
    assert_response :success
  end

end
