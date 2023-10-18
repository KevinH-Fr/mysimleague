// app/javascript/controllers/pari_controller.js
import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";


export default class extends Controller {

 static targets = ["course", "sprint", "mt", "dotd", "dnf", "dns", "score", "pilote", "equipe", "label"]; 

  connect() {
   // console.log("Hello from resultat controller js");
  }

  update_score() {
    const course = parseInt(this.courseTarget.value);
    const sprint = parseInt(this.sprintTarget.value);

    const mt = this.mtTarget.checked; 
    const dotd = this.dotdTarget.checked; 
    const dnf = this.dnfTarget.checked; 
    const dns = this.dnsTarget.checked; 

    //const mtValue = mt && course <= 10 ? 1 : 0; // Set mtValue to 1 if mt is true and course is equal or lower than 10, otherwise 0
    const mtValue = (dnf || dns) ? 0 : (mt && course <= 10 ? 1 : 0);

    const dotdValue = dotd ? 1 : 0; // Set dotdValue to 1 if mt is true, otherwise 0

    const totalScore = this.calculateCourseValue(course, dnf, dns) + 
    this.calculateSprintValue(sprint) + mtValue + dotdValue;

    this.scoreTarget.value = totalScore; // Update the score field value
  //  console.log("call update score : " + totalScore);

  }

  calculateCourseValue(course, dnf, dns) {
    if (dnf || dns) {
      return 0;
    } else if (course === 1) {
      return 25;
    } else if (course === 2) {
      return 18;
    } else if (course === 3) {
      return 15;
    } else if (course === 4) {
      return 12;
    } else if (course === 5) {
      return 10;
    } else if (course === 6) {
      return 8;
    } else if (course === 7) {
      return 6;
    } else if (course === 8) {
      return 4;
    } else if (course === 9) {
      return 2;
    } else if (course === 10) {
      return 1;
    } else {
      return 0;
    }
  }
  

  calculateSprintValue(sprint) {
    if (sprint === 1) {
      return 8;
    } else if (sprint === 2) {
      return 7;
    } else if (sprint === 3) {
      return 6;
    } else if (sprint === 4) {
      return 5;
    } else if (sprint === 5) {
      return 4;
    } else if (sprint === 6) {
      return 3;
    } else if (sprint === 7) {
      return 2;
    } else if (sprint === 8) {
      return 1;
    } else {
      return 0;
    }
  }

  update_equipe() {
    const pilote = this.piloteTarget.value;
    const controller = this; // Store the reference to the controller instance
    
    // Check if piloteTarget has a value (is not empty)

    if (pilote) {
      //console.log("call update equipe - pilote association id: " + pilote );
      $.ajax({
        url: `/association_users/${pilote}`,
        type: 'GET',
        dataType: 'json',
        success: function(response) {
          const equipeId = response.equipe_id;
         // console.log("Equipe ID:", equipeId);
          controller.equipeTarget.value = equipeId || ''; // Use the stored controller reference
        },
        error: function(xhr, status, error) {
          console.error("Error fetching AssociationUser:", error);
        }
      });
    } else {
      controller.equipeTarget.value = ''; 
    }
  }
  

}