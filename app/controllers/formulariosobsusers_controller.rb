class FormulariosobsusersController < ApplicationController
  before_action :set_formulariosobsuser, only: %i[ show edit update destroy ]

  # GET /formulariosobsusers or /formulariosobsusers.json
  def index
    @formulariosobsusers = Formulariosobsuser.all
  end

  # GET /formulariosobsusers/1 or /formulariosobsusers/1.json
  def show
  end

  # GET /formulariosobsusers/new
  def new
    @formulariosobsuser = Formulariosobsuser.new
  end

  # GET /formulariosobsusers/1/edit
  def edit
  end

  # POST /formulariosobsusers or /formulariosobsusers.json
  def create
    @formulariosobsuser = Formulariosobsuser.new(formulariosobsuser_params)

    respond_to do |format|
      if @formulariosobsuser.save
        format.html { redirect_to @formulariosobsuser, notice: "Formulariosobsuser was successfully created." }
        format.json { render :show, status: :created, location: @formulariosobsuser }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @formulariosobsuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formulariosobsusers/1 or /formulariosobsusers/1.json
  def update
    respond_to do |format|
      if @formulariosobsuser.update(formulariosobsuser_params)
        format.html { redirect_to @formulariosobsuser, notice: "Formulariosobsuser was successfully updated." }
        format.json { render :show, status: :ok, location: @formulariosobsuser }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @formulariosobsuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formulariosobsusers/1 or /formulariosobsusers/1.json
  def destroy
    @formulariosobsuser.destroy
    respond_to do |format|
      format.html { redirect_to formulariosobsusers_url, notice: "Formulariosobsuser was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formulariosobsuser
      @formulariosobsuser = Formulariosobsuser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def formulariosobsuser_params
      params.fetch(:formulariosobsuser, {})
    end
end
