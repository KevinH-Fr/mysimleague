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
    const originalColorClass = button.dataset.originalColor;
    
    if (isActive) {
      const activeColorClass = "text-light";
  
      icon.classList.remove(originalColorClass);
      icon.classList.add(activeColorClass);
    } else {
  
      icon.classList.remove("text-light");
      icon.classList.add(originalColorClass);
    }
  }
  
}
