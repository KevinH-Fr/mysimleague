import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
  }

  handleClickPb1(event) {
    const buttons = document.getElementsByClassName("btn-pb1");
    const clickedButton = event.currentTarget;

    for (const button of buttons) {
      if (button === clickedButton) {
        button.classList.add("active");
      } else {
        button.classList.remove("active");
      }
    }

    
  }

  handleClickPb2(event) {
    const buttons = document.getElementsByClassName("btn-pb2");
    const clickedButton = event.currentTarget;

    for (const button of buttons) {
      if (button === clickedButton) {
        button.classList.add("active");
      } else {
        button.classList.remove("active");
      }
    }

  }

  handleClickCorrection(event) {
    const buttons = document.getElementsByClassName("btn-correction");
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
