import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

Chart.register(...registerables);

export default class extends Controller {

  connect() {

    var userStats = JSON.parse(this.data.get("userStats")); // Parse userStats as JSON
    var userName = JSON.parse(this.data.get("userName")); // Parse userStats as JSON

    var userCompareStats = JSON.parse(this.data.get("userCompareStats")); // Parse userStats as JSON

    var ctx = document.getElementById('myChartRadar');

    const datasets = [
      {
        label: userName,
        data: userStats,
        backgroundColor: 'rgba(75, 100, 192, 0.2)',
        borderColor: 'rgba(75, 100, 192, 1)',
        borderWidth: 1
      }
    ];

    if (Array.isArray(userCompareStats) && userCompareStats.length > 0) {
      var userCompareName = JSON.parse(this.data.get("userCompareName")); // Parse userStats as JSON

      datasets.push({
        label: userCompareName,
        data: userCompareStats,
        backgroundColor: 'rgba(240, 128, 128, 0.2)',
        borderColor: 'rgba(240, 128, 128, 1)',
        borderWidth: 1
      });
    }

    const data = {
      labels: ['Victoire', 'Podium', 'Top5', 'Top10'],
      datasets: datasets
    };

    const options = {
      scales: {
        r: {
          beginAtZero: true,
          pointLabels: {
            color: 'white' // Set the label color to white
          }
        }
      },
      plugins: {
        legend: {
          labels: {
            color: 'white' // Set the color of the legend labels to white
          }
        }
      },
    };

    new Chart(ctx, {
      type: 'radar',
      data: data,
      options: options
    });
  }
}
