// app/javascript/controllers/reanimate_gif_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["gif"];
  
    connect() {
      this.reanimateGif();
      console.log("reanimate connected");
    }
  
    reanimateGif() {
      setInterval(() => {
        this.reloadGif();
      }, 5000); // Refresh every 5 seconds (5000 milliseconds)
    }
  
    reloadGif() {
      const gifElement = this.gifTarget;
      const imageUrl = gifElement.getAttribute("src");
  
      // Add a random query parameter to the URL to force reload
      const newImageUrl = `${imageUrl.split("?")[0]}?t=${new Date().getTime()}`;
      gifElement.setAttribute("src", newImageUrl);
    }
  }