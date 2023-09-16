import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

export default class extends Controller {
  async connect() {
    // Dynamically load Chart.js and its dependencies
    Chart.register(...registerables);

    const userResultats = JSON.parse(this.data.get("userResultats"));
    const userName = JSON.parse(this.data.get("userName")); // Parse userStats as JSON
    const ctx = document.getElementById('myChartLine');

    const datasets = [
      {
        label: userName,
        data: userResultats.user.map(resultat => resultat.score),
        fill: true,
        backgroundColor: 'rgba(75, 100, 192, 0.2)',
        borderColor: 'rgba(75, 100, 192, 1)',
        borderWidth: 1
      }
    ];

    if (userResultats.user_compare && userResultats.user_compare.length > 0) {
      const userCompareName = JSON.parse(this.data.get("userCompareName")); // Parse userStats as JSON
      datasets.push({
        label: userCompareName,
        data: userResultats.user_compare.map(resultat => resultat.score),
        fill: true,
        backgroundColor: 'rgba(240, 128, 128, 0.2)',
        borderColor: 'rgba(240, 128, 128, 1)',
        borderWidth: 1
      });
    }

    const data = {
      labels: userResultats.user.map(resultat => resultat.event),
      datasets: datasets
    };

    const options = {
      scales: {
        x: {
          beginAtZero: true,
          ticks: {
            color: 'white' // Set the color of the x-axis labels to white
          }
        },
        y: {
          beginAtZero: true,
          ticks: {
            color: 'white' // Set the color of the y-axis labels to white
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
      tooltips: {
        mode: 'index',
        intersect: false,
        backgroundColor: 'rgba(0, 0, 0, 0.8)', // Set tooltip background color
        titleFontColor: 'white', // Set tooltip title text color to white
        bodyFontColor: 'white', // Set tooltip body text color to white
        footerFontColor: 'white' // Set tooltip footer text color to white
      }
    };

    new Chart(ctx, {
      type: 'line',
      data: data,
      options: options
    });
  }
}
