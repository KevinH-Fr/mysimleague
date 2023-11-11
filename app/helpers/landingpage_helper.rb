module LandingpageHelper
    def svg_animation(file_path, alt_text)
        image_tag("#{file_path}?#{Time.now.to_i}", 
            width: '100%', height: '100%', alt: alt_text, 
            class: "reanimate-svg mb-3",
            style: "max-width: 100%; max-height: 30vh;" )
    end


end
