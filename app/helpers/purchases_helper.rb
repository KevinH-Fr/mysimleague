module PurchasesHelper

    def boolean_user_paid_purchase(user)
      user.purchases.where(status: "paid").exists?
    end

    def user_paid_purchases_icon(user)
      best_purchase = user.purchases.where(status: "paid").max_by { |purchase| purchase.article.niveau }
      
      if best_purchase  
        niveau = best_purchase.article.niveau 
        if niveau == 1 
          color = "brown"
        elsif niveau == 2
          color = "grey"
        elsif niveau == 3 
          color = "yellow"
        else 
          color = "blue"
        end

        content_tag(:span, "#{best_purchase.article.titre}", class: "badge") do 
          content_tag(:i, "", class: "fa fa-2xl fa-crown mx-0", style: "color: #{color}")
        end
      end
    end

end

