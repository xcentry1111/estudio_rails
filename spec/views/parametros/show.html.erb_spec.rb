require 'rails_helper'

RSpec.describe "parametros/show", type: :view do
  before(:each) do
    @parametro = assign(:parametro, Parametro.create!(
      descripcion: "Descripcion",
      observacion: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/MyText/)
  end
end
