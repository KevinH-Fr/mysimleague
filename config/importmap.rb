# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin "jquery", to: "jquery.min.js", preload: true
pin "jquery_ujs", to: "jquery_ujs.js", preload: true

pin "html2canvas", to: "https://ga.jspm.io/npm:html2canvas@1.4.1/dist/html2canvas.js", preload: false

pin "local-time", to: "https://ga.jspm.io/npm:local-time@2.1.0/app/assets/javascripts/local-time.js"
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.2.0/dist/chart.js", preload: false
pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js"

pin "three", to: "https://ga.jspm.io/npm:three@0.158.0/build/three.module.js"

pin_all_from "app/javascript/controllers", under: "controllers"

