// app/javascript/controllers/parametre_setup_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.updateRangeValue();
  }

  updateRangeValue() {
    const parametreId = this.element.dataset.parametreId;
    const rangeValElement = document.getElementById(`rangeval_${parametreId}`);

    this.element.addEventListener("input", () => {
      const rangeValue = this.element.value;
      rangeValElement.innerHTML = rangeValue;
    });
  }
}
