import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-element"
export default class extends Controller {

  static targets = ["submitbtn", "montant", "cote", "parieur", "coureur", "typepari",
  "output"];
  
  connect() {
   // console.log("js form element connected")
    this.submitbtnTarget.hidden = true
  } 

  remotesubmit() {
    this.submitbtnTarget.click()
  }

  setField(event) {
    
    const button = event.target;

   // console.log(button);
    const coureurNom = button.getAttribute('data-coureur-nom');
   // console.log(coureurNom);

    const coureur = button.dataset.coureur;

    const typePari = button.dataset.typepari;
    const cote = button.value;

    this.element.querySelector("[name='pari[association_user_id]']").value = coureur;
    this.element.querySelector("[name='pari[typepari]']").value = typePari;
    this.element.querySelector("[name='pari[cote]']").value = cote;

    const divElement = document.getElementById("div-montant");
    divElement.style.display = "block";
    
    this.update_values(coureurNom);

  }

  update_values(coureurNom) {
    const parieur = this.parieurTarget.value;
    const coureur = this.coureurTarget.value;

    const montant = parseFloat(this.montantTarget.value);
    const cote = parseFloat(this.coteTarget.value);
    const typepari = this.typepariTarget.value;
    const gainPossible = (montant * cote).toFixed(2);
 
    const outputContent = "coureur: " + coureurNom + 
                          " montant: " + montant + " cote: " + cote + " typepari: " + typepari +
                          " gain possible: " + gainPossible;

    this.outputTarget.textContent = outputContent;
  }




}
