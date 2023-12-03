module PurchasesHelper

    #rempalcer badge par un icon crown coloré en fonction du niveau, 
    # ajouter un champ niveau dans article pour mapper la couleur

    def user_paid_purchases(user)
        purchases_list = user.purchases.where(status: "paid")
      
        purchases_list.map do |purchase|
          niveau = purchase.article.niveau 
          if niveau == 1 
            color = "brown"
          elsif niveau == 2
            color = "grey"
          elsif niveau == 3 
            color = "yellow"
          else 
            color = "blue"
          end

          content_tag(:span, "#{purchase.article.titre}", class: "badge") do 
            content_tag(:i, "", class: "fa fa-2xl fa-crown mx-0", style: "color: #{color}")
          end
        end
        .join(" ").html_safe
    end
      
      
end

