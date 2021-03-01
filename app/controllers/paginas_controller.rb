# frozen_string_literal: true

class PaginasController < ApplicationController
  before_action :set_pagina, only: [:show, :edit, :update, :destroy]
  layout :determine_layout

  def grid; end

  # GET /paginas or /paginas.json
  def index
    @paginas = Pagina.all
  end

  # GET /paginas/1 or /paginas/1.json
  def show; end

  # GET /paginas/new
  def new
    @pagina = Pagina.new
  end

  # GET /paginas/1/edit
  def edit; end

  # POST /paginas or /paginas.json
  def create
    @pagina = Pagina.new(pagina_params)

    respond_to do |format|
      if @pagina.save
        format.html { redirect_to @pagina, notice: 'Pagina was successfully created.' }
        format.json { render :show, status: :created, location: @pagina }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pagina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paginas/1 or /paginas/1.json
  def update
    respond_to do |format|
      if @pagina.update(pagina_params)
        format.html { redirect_to @pagina, notice: 'Pagina was successfully updated.' }
        format.json { render :show, status: :ok, location: @pagina }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pagina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paginas/1 or /paginas/1.json
  def destroy
    @pagina.destroy!
    respond_to do |format|
      format.html { redirect_to paginas_url, notice: 'Pagina was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def determine_layout
    if ['index'].include?(action_name)
      'application_login'
    elsif ['grid'].include?(action_name)
      'application_grids'
    else
      'application'
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_pagina
    @pagina = Pagina.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pagina_params
    params.require(:pagina).permit(:titulo, :estado)
  end
end
