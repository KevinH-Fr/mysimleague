module DashboardSetupHelper
    def menus_admin_links
        links = {
          "comportements" => comportements_path,
          "games" => games_path,
          "categorie paramètre" => categorie_parametres_path,
          "base setups" => base_setups_path,
          "comportement base setup" => comportement_base_setups_path,
          "problemes" => problems_path,
          "corrections" => correctifs_path
        }
    
        links.map do |text, path|
          link_to(text, path, class: "btn btn-sm btn-outline-light m-1")
        end.join.html_safe
      end
    
end
