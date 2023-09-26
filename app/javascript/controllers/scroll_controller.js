
// app/javascript/controllers/scroll_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    this.ensureDOMLoaded()
  }

  ensureDOMLoaded() {
    if (document.readyState === "complete") {
      this.scroll()
    } else {
      document.addEventListener("turbo:load", () => this.scroll())
    }
  }

  scroll() {
  //  const targetElement = document.getElementById("target-scroll-id")
  
  const targetElement = this.element

 // console.log("Call scroll from Stimulus" + " " + targetElement)

    if (targetElement) {
      targetElement.scrollIntoView({
        behavior: "smooth",
        block: "center",
      })
    }
  }
}
