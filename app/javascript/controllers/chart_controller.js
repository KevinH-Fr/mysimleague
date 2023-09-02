import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from 'https://cdn.skypack.dev/chart.js';

Chart.register(...registerables);

export default class extends Controller {

  connect() {
    var userStats = JSON.parse(this.data.get("userStats")); // Parse userStats as JSON
    var userCompareStats = JSON.parse(this.data.get("userCompareStats")); // Parse userStats as JSON

    var ctx = document.getElementById('myChartRadar');

    const datasets = [
      {
        label: 'Main',
        data: userStats,
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1
      }
    ];

    if (Array.isArray(userCompareStats) && userCompareStats.length > 0) {
      datasets.push({
        label: 'Second',
        data: userCompareStats,
        backgroundColor: 'rgba(75, 100, 192, 0.2)',
        borderColor: 'rgba(75, 100, 192, 1)',
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
          beginAtZero: true
        }
      }
    };

    new Chart(ctx, {
      type: 'radar',
      data: data,
      options: options
    });
  }
}
