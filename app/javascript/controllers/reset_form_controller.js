import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
   //console.log("reset form controller connected")
  }

  reset() {
  //  this.element.reset()

  //  console.log("call hide form")

    // Get the elements by their ids
   // const collapseNewElement = document.getElementById('collapseNew');

    // Create Bootstrap Collapse instances for each element
   // const bootstrapCollapseNew = new bootstrap.Collapse(collapseNewElement);

    // Use the Bootstrap Collapse hide method on each instance
  //  bootstrapCollapseNew.hide();


   }

   hide_new_form() {
 //   console.log("call hide new form ");

   // const divNewForm = document.getElementById("collapseNewEvent");

    // divNewForm.style.display = "none";
   }


}

