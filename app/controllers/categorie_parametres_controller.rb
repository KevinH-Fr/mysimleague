class CategorieParametresController < InheritedResources::Base

  private

    def categorie_parametre_params
      params.require(:categorie_parametre).permit(:game_id, :val_categorie)
    end

end
