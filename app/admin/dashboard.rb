# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
   
    panel "Info" do
      para "Welcome to ActiveAdmin."
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Equipes" do
          ul do
            Equipe.recent(5).map do |equipe|
              li link_to(equipe.nom, admin_equipe_path(equipe))
            end
          end
        end
      end

      column do
        panel "Recent Events" do
          ul do
            Event.recent(5).map do |event|
              li link_to(event.numero, admin_event_path(event))
            end
          end
        end
      end
    end

    columns do
      column do
        panel "Recent Users" do
          ul do
            User.recent(5).map do |user|
              li link_to(user.nom, admin_user_path(user))
            end
          end
        end
      end

      column do
        panel "Recent Ligues" do
          ul do
            Ligue.recent(5).map do |ligue|
              li link_to(ligue.nom, admin_ligue_path(ligue))
            end
          end
        end
      end

      column do
        panel "Recent paris" do
          ul do
            Pari.recent(5).map do |pari|
              li link_to(pari.id, admin_pari_path(pari))
            end
          end
        end          
      end

      column do
        panel "Recent licences" do
          ul do
            Licence.recent(5).map do |licence|
              li link_to(licence.id, admin_licence_path(licence))
            end
          end
        end
      end

      column do
        panel "Recent association user" do
          ul do
            AssociationUser.recent(5).map do |association_user|
              li link_to(association_user.id, admin_association_user_path(association_user))
            end
          end
        end
      end



    end

  end
end
