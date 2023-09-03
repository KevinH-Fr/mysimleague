import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from 'https://cdn.skypack.dev/chart.js';

Chart.register(...registerables);

export default class extends Controller {

  connect() {

    var userResultats = JSON.parse(this.data.get("userResultats"));
    var userName = JSON.parse(this.data.get("userName")); // Parse userStats as JSON
    
    var ctx = document.getElementById('myChartLine');

    const datasets = [
      {
        label: userName,
        data: userResultats.user.map(resultat => resultat.score),
        fill: true, // Set to false to create a line chart
        backgroundColor: 'rgba(75, 100, 192, 0.2)',
        borderColor: 'rgba(75, 100, 192, 1)',
        borderWidth: 1
      }
    ];

    const data = {
      labels: userResultats.user.map(resultat => resultat.event),
      datasets: datasets
    };

        // Check if user_compare data exists
        if (userResultats.user_compare && userResultats.user_compare.length > 0) {
          var userCompareName = JSON.parse(this.data.get("userCompareName")); // Parse userStats as JSON

          datasets.push({
            label: userCompareName,
            data: userResultats.user_compare.map(resultat => resultat.score),
            fill: true,
            backgroundColor: 'rgba(240, 128, 128, 0.2)',
            borderColor: 'rgba(240, 128, 128, 1)',
            borderWidth: 1
          });
        }

    const options = {
      scales: {
        x: {
          beginAtZero: true
        },
        y: {
          beginAtZero: true
        }
      }
    };

    new Chart(ctx, {
      type: 'line',
      data: data,
      options: options
    });
  }
}
