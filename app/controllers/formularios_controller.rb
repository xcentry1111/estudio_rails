# frozen_string_literal: true

class FormulariosController < ApplicationController
  before_action :set_formulario, only: [:show, :edit, :update, :destroy]
  layout :determine_layout
  include ::ModuleConcerns

  def pagina; end

  def index
    @formularios = Formulario.all
    @titulo = FormularioProducto::Account.new('Andres Felipe', ' Pelaez').descripcion_titulo
    @controller_concern = prueba(@titulo)
  end

  # GET /formularios/1 or /formularios/1.json
  def show; end

  # GET /formularios/new
  def new
    @formulario = Formulario.new
  end

  # GET /formularios/1/edit
  def edit; end

  # POST /formularios or /formularios.json
  def create
    @formulario = Formulario.new(formulario_params)

    respond_to do |format|
      if @formulario.save
        format.html { redirect_to @formulario, notice: 'Formulario was successfully created.' }
        format.json { render :show, status: :created, location: @formulario }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @formulario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formularios/1 or /formularios/1.json
  def update
    respond_to do |format|
      if @formulario.update(formulario_params)
        format.html { redirect_to @formulario, notice: 'Formulario was successfully updated.' }
        format.json { render :show, status: :ok, location: @formulario }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @formulario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formularios/1 or /formularios/1.json
  def destroy
    @formulario.destroy!
    respond_to do |format|
      format.html { redirect_to formularios_url, notice: 'Formulario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def determine_layout
    if ['pagina'].include?(action_name)
      'application_login'
    else
      'application'
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_formulario
    @formulario = Formulario.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def formulario_params
    params.require(:formulario).permit(:nombre, :email, :observacion)
  end
end
