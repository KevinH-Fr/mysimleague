class EquipesController < ApplicationController

  before_action :set_equipe, only: %i[ show edit update destroy ]
  before_action :authorize_admin, only: %i[ new create edit update destroy ]

  def index
    @equipes = Equipe.all
  end

  def show
  end

  def new
    @equipe = Equipe.new
  end

  def edit
    respond_to do |format|
      format.html 
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@equipe, 
          partial: "equipes/form", 
          locals: {equipe: @equipe})
      end
    end
  end

  def create
    @equipe = Equipe.new(equipe_params)

    respond_to do |format|
      if @equipe.save
        flash.now[:success] = "equipe was successfully created"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_equipe',
                                partial: "equipes/form",
                                locals: { equipe: Equipe.new }),
  
            turbo_stream.append('equipes',
                                 partial: "equipes/equipe",
                                 locals: { equipe: @equipe }),
            turbo_stream.prepend('flash', partial: 'layouts/flash', locals: { flash: flash })
            
          ]
        end

        format.html { redirect_to equipe_url(@equipe), notice: "Equipe was successfully created." }
        format.json { render :show, status: :created, location: @equipe }
      else

        format.turbo_stream do
          render turbo_stream.update(
            'new_equipe',
            partial: "equipes/form",
            locals: { equipe: @equipe }
          )
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @equipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @equipe.update(equipe_params)
        flash.now[:success] = "Equipe was successfully updated"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@equipe, 
                    partial: 'equipes/equipe', 
                    locals: { equipe: @equipe }),
            turbo_stream.prepend('flash', partial: 'layouts/flash', locals: { flash: flash })
          ]
        end

        format.html { redirect_to equipe_url(@equipe), notice: "Equipe was successfully updated." }
        format.json { render :show, status: :ok, location: @equipe }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@equipe, 
                    partial: 'equipes/form', 
                    locals: { equipe: @equipe })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @equipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @equipe.destroy

    respond_to do |format|
      format.html { redirect_to equipes_url, notice: "Equipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def logo_url
    equipe = Equipe.find(params[:id])
    equipe_logo_url = url_for(equipe.logo)
    render plain: equipe_logo_url
  end

  private

  def authorize_admin
    unless current_user && current_user.admin 
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def set_equipe
    @equipe = Equipe.find(params[:id])
  end

  def equipe_params
    params.require(:equipe).permit(:nom, :couleurs, :logo, :voiture, :banniere)
  end
end
