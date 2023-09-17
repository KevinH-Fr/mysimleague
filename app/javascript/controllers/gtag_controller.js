import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {

    console.log("call gtag");
    // Load Google Analytics script asynchronously
    const script = document.createElement("script");
    script.async = true;
    script.src = "https://www.googletagmanager.com/gtag/js?id='G-8LZY8X784Z'";

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

    // Add TurboFrames listener to initialize Google Analytics on page change
    const isInitialLoad = true;
    document.addEventListener("turbo:load", () => {
      if (isInitialLoad) {
        isInitialLoad = false;
        return;
      }
      gtag("config", "G-8LZY8X784Z", {
        page_path: window.location.pathname,
      });
    });
  }
}
