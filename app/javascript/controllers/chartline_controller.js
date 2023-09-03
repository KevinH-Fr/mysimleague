import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from 'https://cdn.skypack.dev/chart.js';

Chart.register(...registerables);

export default class extends Controller {

  connect() {
    console.log("connect chartline controller");

    // Parse userStats and userCompareStats as JSON
    var userResultats = JSON.parse(this.data.get("userResultats"));

    console.log(userResultats);
    var userCompareStats = JSON.parse(this.data.get("userCompareStats"));

    var ctx = document.getElementById('myChartLine');

    const datasets = [
      {
        label: 'Main',
        data: userResultats,
        fill: false, // Set to false to create a line chart
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1
      }
    ];

    if (Array.isArray(userCompareStats) && userCompareStats.length > 0) {
      datasets.push({
        label: 'Second',
        data: userCompareStats,
        fill: false, // Set to false to create a line chart
        borderColor: 'rgba(75, 100, 192, 1)',
        borderWidth: 1
      });
    }

    const data = {
      labels: ['Victoire', 'Podium', 'Top5', 'Top10'],
      // get dates of race scores 
      datasets: datasets
    };

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
