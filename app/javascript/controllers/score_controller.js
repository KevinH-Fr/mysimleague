import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="score"
// permet la mise a jour du score en fonction de 
// la saisie dans les fields du form resultat
export default class extends Controller {

  // champs dans le form resultat
  static targets = [ "course", "score", "dotd", "mt" ]

  // methode de connexion du controller (ficher courant)
  connect() {
    // envoi d'un message dans la console du navigateur pour verifier que le fichier est appelé
    console.log('connect from score controller');
  } 

  calculateScore() {
    console.log('calculate score');

    const courseField = parseInt(this.courseTarget.value);
    let scorePosition;

    if (courseField == 1) {
        scorePosition = 25;
    } else if (courseField == 2) {
        scorePosition = 18;
    } else if (courseField == 3) {
        scorePosition = 15;
    } else if (courseField == 4) {
        scorePosition = 12;
    } else if (courseField == 5) {
        scorePosition = 10;
    } else if (courseField == 6) {
        scorePosition = 8;
    } else if (courseField == 7) {
        scorePosition = 6;
    } else if (courseField == 8) {
        scorePosition = 4;
    } else if (courseField == 9) {
        scorePosition = 2;
    } else if (courseField == 10) {
        scorePosition = 1;
    } else {
        scorePosition = 0;
    }

    const dotdField = this.dotdTarget.checked;
    let scoreDotd;

    if (dotdField == true) { 
        scoreDotd = 1;
    } else {
        scoreDotd = 0;
    } 

    const mtField = this.mtTarget.checked;
    let scoreMt;

    if (mtField == true) { 
        scoreMt = 1;
    } else {
        scoreMt = 0;
    } 

    let totalScore = scorePosition + scoreDotd + scoreMt;
    this.updateScore(totalScore);
  }

  updateScore(totalScore) {
    console.log('update score');   
    this.scoreTarget.value = totalScore; 
  }
}
