import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"];

  connect() {
    // Initialize the select element
    this.selectTarget.addEventListener("change", () => this.submitForm());
  }

  submitForm() {

    const submitButton = this.element.querySelector("#submit_button");
    if (submitButton) {
      submitButton.click();
    }
  }

}