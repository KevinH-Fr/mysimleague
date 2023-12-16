class ComportementsController < InheritedResources::Base

  private

    def comportement_params
      params.require(:comportement).permit(:nom, :principal, :label_categorie)
    end

end
