import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
  //  console.log("js form doi connected");
  }

  remotesubmit(event) {
  //  console.log("call remote submit doi");

    const formElement = this.element;
    const recordId = formElement.dataset.formDoiRecordId;
    //console.log("Record ID:", recordId);

    const selectElement = event.target;
    const decision = selectElement.value;
    //console.log("decision:", decision);

    const responsableDiv = document.getElementById(`content-responsable-doi-${recordId}`);
    //console.log("responsableDiv", responsableDiv);

   // if (responsableDiv) {
      if (decision === "responsable") {
        //console.log("call show pour responsable");
        responsableDiv.style.display = "block";
      } else {
        responsableDiv.style.display = "none";
      }
    //}
  }
}
