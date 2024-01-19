import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {

    console.log("Controller connected");

    // Retrieve the target value from the data attribute
    const targetValue = parseInt(this.element.dataset.targetValue);

    // Set the initial value of the counter
    let count = 0;

    // Create an animation to count from 0 to the target value with easing
    $(this.element).animate(
      {
        text: targetValue,
      },
      {
        duration: 2000,
        easing: "swing",
        step: (now) => {
          count = Math.floor(now);
          this.element.textContent = count;
        },
        complete: () => {
          console.log("Animation complete!");
        },
      }
    );
  }
}
