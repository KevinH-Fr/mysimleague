import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-rattachement"
export default class extends Controller {

  static targets = ["ligue", "message"];
  
  connect() {
  //  console.log("js form rattachement connected")
  } 

  setField(event) {
    
    const button = event.target;
    const ligue = button.dataset.ligue;
    const ligueNom = button.dataset.ligueNom; // Correct attribute name
  
    const textMessage = "Merci de m'ajouter à la ";

    this.ligueTarget.value = ligue;
    this.messageTarget.value = textMessage + ligueNom;

  }

}
