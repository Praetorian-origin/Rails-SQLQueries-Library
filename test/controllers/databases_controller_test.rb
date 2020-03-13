require 'test_helper'

class DatabasesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get databases_new_url
    assert_response :success
  end

  test "should get create" do
    get databases_create_url
    assert_response :success
  end

  test "should get update" do
    get databases_update_url
    assert_response :success
  end

  test "should get delete" do
    get databases_delete_url
    assert_response :success
  end

  test "should get index" do
    get databases_index_url
    assert_response :success
  end

  test "should get show" do
    get databases_show_url
    assert_response :success
  end

end
