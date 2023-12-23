class CategorieParametresController < InheritedResources::Base

  before_action :set_categorie_parametre, only: %i[ show edit update destroy ]
  before_action :authorize_admin, only: %i[ new create edit update index destroy ]

  def create
    @categorie_parametre = CategorieParametre.new(categorie_parametre_params)

    respond_to do |format|
      if @categorie_parametre.save

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_categorie_parametre', partial: 'categorie_parametres/form', locals: { categorie_parametre: CategorieParametre.new }),
            turbo_stream.prepend('categorie_parametres', partial: 'categorie_parametres/categorie_parametre', locals: { categorie_parametre: @categorie_parametre })
          ]
        end

        format.html { redirect_to categorie_parametre_url(@categorie_parametre), notice: "categorie_parametre was successfully created." }
        format.json { render :show, status: :created, location: @categorie_parametre }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update('new_categorie_parametre', partial: 'categorie_parametres/form', locals: { categorie_parametre: @categorie_parametre})
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @categorie_parametre.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@categorie_parametre, partial: 'categorie_parametres/form', locals: { categorie_parametre: @categorie_parametre })
      end
    end
  end

  
  def update

    respond_to do |format|
      if @categorie_parametre.update(categorie_parametre_params)


        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@categorie_parametre, partial: 'categorie_parametres/categorie_parametre', locals: { categorie_parametre: @categorie_parametre })
        end

        format.html { redirect_to categorie_parametre_url(@categorie_parametre), notice: "categorie_parametre was successfully updated." }
        format.json { render :show, status: :ok, location: @categorie_parametre }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@categorie_parametre, partial: 'categorie_parametres/form', locals: { categorie_parametre: @categorie_parametre })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @categorie_parametre.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
    @categorie_parametre.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@categorie_parametre) }
      format.html { redirect_to categorie_parametres_url, notice: "categorie_parametre was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_categorie_parametre
      @categorie_parametre = CategorieParametre.find(params[:id])
    end

    def categorie_parametre_params
      params.require(:categorie_parametre).permit(:game_id, :val_categorie)
    end

    def authorize_admin
      unless current_user && current_user.admin 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
    
end
