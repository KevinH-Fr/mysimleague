module SetupsHelper
    def categorie_title(title)
        content_tag(:span, title, class: 'fw-bold')
    end

    def label_value_content(label, content)
        content_tag(:span, "#{label}: #{content}", class: 'badge bg-secondary')
    end
    
end
