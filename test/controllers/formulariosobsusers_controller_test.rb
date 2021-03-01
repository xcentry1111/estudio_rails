require 'test_helper'

class FormulariosobsusersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @formulariosobsuser = formulariosobsusers(:one)
  end

  test "should get index" do
    get formulariosobsusers_url
    assert_response :success
  end

  test "should get new" do
    get new_formulariosobsuser_url
    assert_response :success
  end

  test "should create formulariosobsuser" do
    assert_difference('Formulariosobsuser.count') do
      post formulariosobsusers_url, params: { formulariosobsuser: {  } }
    end

    assert_redirected_to formulariosobsuser_url(Formulariosobsuser.last)
  end

  test "should show formulariosobsuser" do
    get formulariosobsuser_url(@formulariosobsuser)
    assert_response :success
  end

  test "should get edit" do
    get edit_formulariosobsuser_url(@formulariosobsuser)
    assert_response :success
  end

  test "should update formulariosobsuser" do
    patch formulariosobsuser_url(@formulariosobsuser), params: { formulariosobsuser: {  } }
    assert_redirected_to formulariosobsuser_url(@formulariosobsuser)
  end

  test "should destroy formulariosobsuser" do
    assert_difference('Formulariosobsuser.count', -1) do
      delete formulariosobsuser_url(@formulariosobsuser)
    end

    assert_redirected_to formulariosobsusers_url
  end
end
