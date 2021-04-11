require 'rails_helper'

RSpec.describe "parametros/new", type: :view do
  before(:each) do
    assign(:parametro, Parametro.new(
      descripcion: "MyString",
      observacion: "MyText"
    ))
  end

  it "renders new parametro form" do
    render

    assert_select "form[action=?][method=?]", parametros_path, "post" do

      assert_select "input[name=?]", "parametro[descripcion]"

      assert_select "textarea[name=?]", "parametro[observacion]"
    end
  end
end
