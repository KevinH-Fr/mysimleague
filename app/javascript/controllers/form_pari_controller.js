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
   // console.log("call set field");
    const button = event.target;

    const coureur = button.dataset.coureur;
    const coureurNom = button.dataset.coureurNom;
    const typePari = button.dataset.typepari;
    const cote = button.value;

    this.element.querySelector("[name='pari[association_user_id]']").value = coureur;
    this.element.querySelector("[name='pari[typepari]']").value = typePari;
    this.element.querySelector("[name='pari[cote]']").value = cote;

    const divElement = document.getElementById("div-montant");
    divElement.style.display = "block";
    
    this.update_values();

  }

  update_values() {
  //  console.log("call update value");
    const parieur = this.parieurTarget.value;
  //  console.log(parieur);
    const coureur = this.coureurTarget.value;
    const montant = parseFloat(this.montantTarget.value);
    const cote = parseFloat(this.coteTarget.value);
    const typepari = this.typepariTarget.value;
    const gainPossible = (montant * cote).toFixed(2);
 
  const outputContent = "parieur: " + parieur + " coureur: " + coureur + 
                          " montant: " + montant + " cote: " + cote + " typepari: " + typepari +
                          " gain possible: " + gainPossible;

    //console.log(outputContent );
    this.outputTarget.textContent = outputContent;
  }






}
