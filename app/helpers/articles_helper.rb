module ArticlesHelper

    def colored_by_niveau(niveau, titre)
        if niveau == 1 
            content_tag(:div, titre, style: "color: brown;")
        elsif niveau == 2
            content_tag(:div, titre, style: "color: silver;")
        elsif niveau == 3
            content_tag(:div, titre, style: "color: gold;")
        else
            content_tag(:div, titre, style: "color: lightblue;")
        end
    end
end
