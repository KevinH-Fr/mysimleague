module ResultatsHelper

  def dotd_mt_dnf_dns_indicators(dotd, mt, dnf, dns)
    content = []

    if dotd
      content << content_tag(:i, "", class: "fa fa-star fa-lg icon-indicator-resultat fw-bold pe-1")
    end

    if mt
      content << content_tag(:i, "", class: "fa fa-stopwatch-20 fa-lg icon-indicator-resultat fw-bold pe-1")
    end

    if dnf
      content << content_tag(:span, "DNF", class: "badge p-1 text-center rounded bg-light text-danger fw-bold me-1")
    end

    if dns
      content << content_tag(:span, "DNS", class: "badge p-1 text-center rounded bg-light text-danger fw-bold me-1")
    end

    content_span = content_tag(:span, content.join(" ").html_safe, 
      class: "text-light fw-bold  position-absolute end-0 top-50 translate-middle-y")
    content_span
  end

  def equipe_banner_pilote_and_indicators(equipe, pilote, dotd, mt, dnf, dns)
    if equipe.banniere.present?
      banner_and_pilote = equipe_banner_with_data(equipe, pilote)
      indicators = dotd_mt_dnf_dns_indicators(dotd, mt, dnf, dns)
      
      content_tag(:div, class: "equipe-banner-wrapper", style: "position: relative; ") do
        [banner_and_pilote, indicators].join.html_safe
      end
    end
  end


end
