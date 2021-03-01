require 'test_helper'

class FormulariosobservacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @formulariosobservacion = formulariosobservaciones(:one)
  end

  test "should get index" do
    get formulariosobservaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_formulariosobservacion_url
    assert_response :success
  end

  test "should create formulariosobservacion" do
    assert_difference('Formulariosobservacion.count') do
      post formulariosobservaciones_url, params: { formulariosobservacion: { formulario_id: @formulariosobservacion.formulario_id, observation: @formulariosobservacion.observation, title: @formulariosobservacion.title } }
    end

    assert_redirected_to formulariosobservacion_url(Formulariosobservacion.last)
  end

  test "should show formulariosobservacion" do
    get formulariosobservacion_url(@formulariosobservacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_formulariosobservacion_url(@formulariosobservacion)
    assert_response :success
  end

  test "should update formulariosobservacion" do
    patch formulariosobservacion_url(@formulariosobservacion), params: { formulariosobservacion: { formulario_id: @formulariosobservacion.formulario_id, observation: @formulariosobservacion.observation, title: @formulariosobservacion.title } }
    assert_redirected_to formulariosobservacion_url(@formulariosobservacion)
  end

  test "should destroy formulariosobservacion" do
    assert_difference('Formulariosobservacion.count', -1) do
      delete formulariosobservacion_url(@formulariosobservacion)
    end

    assert_redirected_to formulariosobservaciones_url
  end
end
