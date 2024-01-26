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
        this.changeIconColor(button, true);
      } else {
        button.classList.remove("active");
        this.changeIconColor(button, false);
      }
    }

    
  }

  changeIconColor(button, isActive) {
    const icon = button.querySelector(".fa");
    const originalColor = button.dataset.originalColor || "text-light";
    const iconColor = button.dataset.iconColor || originalColor;

    if (isActive) {
      icon.style.color = "white";
    } else {
      icon.style.color = iconColor;
    }
  }

  
}
