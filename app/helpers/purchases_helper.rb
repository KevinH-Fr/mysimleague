module PurchasesHelper

    def boolean_user_paid_purchase(user)
      user.purchases.where(status: "paid").exists?
    end

    def user_paid_purchases_icon(user)
      best_purchase = user.purchases.where(status: "paid").max_by { |purchase| purchase.article.niveau.to_i }
    
      if best_purchase
        niveau = best_purchase.article.niveau
        color = case niveau
                when 1 then "brown"
                when 2 then "grey"
                when 3 then "yellow"
                else "blue"
                end
    
        content_tag(:span, best_purchase.article.titre, class: "badge") do
          content_tag(:i, "", class: "fa fa-2x fa-crown mx-0", style: "color: #{color}")
        end
      end
    end
    

end

