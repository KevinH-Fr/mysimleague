import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  //  console.log("call google analytics")
    // Load Google Analytics script asynchronously
    const script = document.createElement("script");
    script.src = "https://www.googletagmanager.com/gtag/js?id=G-8LZY8X784Z";
    script.async = true;

    script.onload = () => {
      // Initialize Google Analytics after the script has loaded
      window.dataLayer = window.dataLayer || [];
      function gtag() {
        dataLayer.push(arguments);
      }
      gtag("js", new Date());
      gtag("config", "G-8LZY8X784Z");
    };

    // Append the script to the document
    document.head.appendChild(script);
  }
}