module PurchasesHelper

    #rempalcer badge par un icon crown coloré en fonction du niveau, 
    # ajouter un champ niveau dans article pour mapper la couleur

    def user_paid_purchases(user)
        user.purchases
          .select { |purchase| purchase.status == "paid" }
          .map { |purchase| content_tag(:span, purchase.article.titre, class: "badge bg-success mx-1") }
          .join(" ").html_safe
      end
      
      
end
