import { Controller } from "@hotwired/stimulus";
import html2canvas from "html2canvas";

export default class extends Controller {
  capture() {
    const elementToCapture = document.getElementById("captureContainer"); // Replace with the actual ID or class of the element you want to capture

    if (elementToCapture) {
  
      const nomDoc = this.element.dataset.nomDoc; 

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
          a.download = nomDoc + '.jpg';
          a.click();
        });
      }
  }
}
