import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="activebutton"
export default class extends Controller {
    static targets = ["openButton"]
  
    connect() {
      console.log("activebutton controller connected.")
    }
  
    changeFormat() {
      console.log("activebutton clicked change format.")
      this.openButtonTarget.classList.add("bg-primary")
    }
  }