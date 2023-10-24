import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
  }

  handleClick(event) {
    const buttons = document.getElementsByClassName("btn-topic");
    const clickedButton = event.currentTarget;

    for (const button of buttons) {
      if (button === clickedButton) {
        button.classList.add("active");
      } else {
        button.classList.remove("active");
      }
    }

    
  }


}
