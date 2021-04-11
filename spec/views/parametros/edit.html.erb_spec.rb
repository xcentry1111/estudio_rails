require 'rails_helper'

RSpec.describe "parametros/edit", type: :view do
  before(:each) do
    @parametro = assign(:parametro, Parametro.create!(
      descripcion: "MyString",
      observacion: "MyText"
    ))
  end

  it "renders the edit parametro form" do
    render

    assert_select "form[action=?][method=?]", parametro_path(@parametro), "post" do

      assert_select "input[name=?]", "parametro[descripcion]"

      assert_select "textarea[name=?]", "parametro[observacion]"
    end
  end
end
