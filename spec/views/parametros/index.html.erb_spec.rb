require 'rails_helper'

RSpec.describe "parametros/index", type: :view do
  before(:each) do
    assign(:parametros, [
      Parametro.create!(
        descripcion: "Descripcion",
        observacion: "MyText"
      ),
      Parametro.create!(
        descripcion: "Descripcion",
        observacion: "MyText"
      )
    ])
  end

  it "renders a list of parametros" do
    render
    assert_select "tr>td", text: "Descripcion".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
