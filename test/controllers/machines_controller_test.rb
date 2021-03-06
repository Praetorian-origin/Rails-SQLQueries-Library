require 'test_helper'

class MachinesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get machines_new_url
    assert_response :success
  end

  test "should get create" do
    get machines_create_url
    assert_response :success
  end

  test "should get update" do
    get machines_update_url
    assert_response :success
  end

  test "should get delete" do
    get machines_delete_url
    assert_response :success
  end

  test "should get index" do
    get machines_index_url
    assert_response :success
  end

  test "should get show" do
    get machines_show_url
    assert_response :success
  end

end
