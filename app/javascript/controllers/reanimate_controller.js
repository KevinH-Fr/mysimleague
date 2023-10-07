// app/javascript/controllers/reanimate_gif_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["gif"];
  
    connect() {
      this.reanimateGif();
    }
  
    reanimateGif() {
      this.reloadGif();
      const randomInterval = this.getRandomInterval(2000, 4000); // Random interval between 2 and 4 seconds
      setTimeout(() => {
        this.reanimateGif();
      }, randomInterval);
    }
  
    reloadGif() {
      const gifElement = this.gifTarget;
      const imageUrl = gifElement.getAttribute("src");
  
      // Add a random query parameter to the URL to force reload
      const newImageUrl = `${imageUrl.split("?")[0]}?t=${new Date().getTime()}`;
      gifElement.setAttribute("src", newImageUrl);
    }

    getRandomInterval(min, max) {
      return Math.floor(Math.random() * (max - min + 1)) + min;
    }
}
