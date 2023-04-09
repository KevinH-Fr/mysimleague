import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="activebutton"
export default class extends Controller {
    static targets = ["buttonTarget"]
  
    connect() {
      console.log("activebutton controller connected.")
    }
  
    changeFormat() {
      console.log("activebutton clicked change format.")
      this.buttonTarget.classList.remove("btn-secondary")
      this.buttonTarget.classList.add("btn-primary")
    }
  }