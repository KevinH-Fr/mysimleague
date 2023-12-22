module CorrectionsHelper

    def icon_sens_modif(sens)
        if sens == "monter"
            content_tag(:i, "", class: "fa fa-angles-up text-sucess")
          else
            content_tag(:i, "", class: "fa fa-angles-down text-danger")
        end
    end
end
