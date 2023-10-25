
// app/javascript/controllers/scroll_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    this.ensureDOMLoaded()
 //   console.log("Call scroll");

  }

  ensureDOMLoaded() {
    if (document.readyState === "complete") {
      this.scroll()
    } else {
      document.addEventListener("turbo:load", () => this.scroll())
    }
  }

  scroll() {
  
  const targetElement = this.element

//  console.log("Call scroll start");

    if (targetElement) {
      targetElement.scrollIntoView({
        behavior: "smooth",
        block: "start",
      })
    }
  }

  scrollDown() {
  
    const targetElement = this.element
  
  //  console.log("Call scroll botttom");
  
      if (targetElement) {
        targetElement.scrollIntoView({
          behavior: "smooth",
          block: "end",
        })
      }
    }


}
