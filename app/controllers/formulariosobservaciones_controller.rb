class FormulariosobservacionesController < ApplicationController
  before_action :set_formulariosobservacion, only: %i[ show edit update destroy ]

  # GET /formulariosobservaciones or /formulariosobservaciones.json
  def index
    @formulariosobservaciones = Formulariosobservacion.all
  end

  # GET /formulariosobservaciones/1 or /formulariosobservaciones/1.json
  def show
  end

  # GET /formulariosobservaciones/new
  def new
    @formulariosobservacion = Formulariosobservacion.new
  end

  # GET /formulariosobservaciones/1/edit
  def edit
  end

  # POST /formulariosobservaciones or /formulariosobservaciones.json
  def create
    @formulariosobservacion = Formulariosobservacion.new(formulariosobservacion_params)

    respond_to do |format|
      if @formulariosobservacion.save
        format.html { redirect_to @formulariosobservacion, notice: "Formulariosobservacion was successfully created." }
        format.json { render :show, status: :created, location: @formulariosobservacion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @formulariosobservacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formulariosobservaciones/1 or /formulariosobservaciones/1.json
  def update
    respond_to do |format|
      if @formulariosobservacion.update(formulariosobservacion_params)
        format.html { redirect_to @formulariosobservacion, notice: "Formulariosobservacion was successfully updated." }
        format.json { render :show, status: :ok, location: @formulariosobservacion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @formulariosobservacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formulariosobservaciones/1 or /formulariosobservaciones/1.json
  def destroy
    @formulariosobservacion.destroy
    respond_to do |format|
      format.html { redirect_to formulariosobservaciones_url, notice: "Formulariosobservacion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formulariosobservacion
      @formulariosobservacion = Formulariosobservacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def formulariosobservacion_params
      params.require(:formulariosobservacion).permit(:formulario_id, :title, :observation)
    end
end
