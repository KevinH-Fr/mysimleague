import { Controller } from "@hotwired/stimulus";
import html2canvas from "html2canvas";

export default class extends Controller {
  capture() {
    const elementToCapture = document.getElementById("captureContainer"); // Replace with the actual ID or class of the element you want to capture

    if (elementToCapture) {
  
      const nomDoc = this.element.dataset.nomDoc; 
      const nomLigue = this.element.dataset.nomLigue; 
      const nomSaison = this.element.dataset.nomSaison; 
      const nomDivision = this.element.dataset.nomDivision; 
      const eventNumero = this.element.dataset.eventNumero; // Access event ID from the button's dataset

        html2canvas(elementToCapture, {
          scale: 2, // Increase the rendering scale
          logging: true,
          letterRendering: 1,
          allowTaint: false,
          useCORS: true
        }).then(function (canvas) {
          var screenshot = canvas.toDataURL("image/jpeg");
          var a = document.createElement("a");
          a.href = screenshot;
          a.download = nomDoc + "_" + nomLigue +  "_" + nomSaison +  "_" + nomDivision +  "_" + eventNumero + '.jpg';
          a.click();
        });
      }
  }
}
