require 'rails_helper'

describe "Formulario", type: :feature do
  it "Creacion de formulario" do
    visit "formularios/new"
    fill_in "formulario_nombre", with: "Mi primer rspec"
    fill_in "formulario_email", with: "apelaez.code@gmail.com"
    fill_in "formulario_observacion", with: "Esto es una prueba de lo que guarda el formulario"
    find("input[type='submit']").click
    expect(page).to have_content("Esto es una prueba de lo que guarda el formulario")
  end
end
