// app/javascript/controllers/pari_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

 static targets = ["decision", "reglement", "penalite_points", "penalite_temps"]; 

  connect() {
    console.log("Hello from new doi controller js");
  }

  update_penalite() {
    const reglement = this.reglementTarget.value;
    console.log("reglement", reglement);
  
    const controller = this; // Store the reference to the controller instance
  
    if (reglement) {
      console.log("call update reglement id: " + reglement);
      $.ajax({
        url: `/reglements/${reglement}`,
        type: 'GET',
        dataType: 'json',
        success: function(response) {
          const penalite_points = response.penalite_points; 
          const penalite_temps = response.penalite_temps; 

          console.log("reglement ID:", reglement);
          console.log("penalite points:", penalite_points);
  
          controller.penalite_pointsTarget.value = penalite_points || '';
          controller.penalite_tempsTarget.value = penalite_temps || '';

        },
        error: function(xhr, status, error) {
          console.error("Error fetching reglement:", error);
        }
      });
    } else {
      controller.penalite_pointsTarget.value = '';
      controller.penalite_tempsTarget.value = '';

    }
  }
  
  

}