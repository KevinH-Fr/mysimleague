import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

Chart.register(...registerables);

export default class extends Controller {
  connect() {
    var setupStats = JSON.parse(this.data.get("setupStats"));

    var ctx = document.getElementById('myChartRadar');

    const labels = setupStats.map(data => data.category);
    const dataValues = setupStats.map(data => data.score);

    const datasets = [
      {
        label: "Score",
        data: dataValues,
        backgroundColor: 'rgba(75, 100, 192, 0.2)',
        borderColor: 'rgba(75, 100, 192, 1)',
        borderWidth: 1
      }
    ];

    const data = {
      labels: labels,
      datasets: datasets
    };

    const options = {
      scales: {
        r: {
          beginAtZero: true,
          pointLabels: {
            color: 'white'
          },
          grid: {
            color: 'rgb(60, 60, 60)' 
          }
        }
      },
      plugins: {
        legend: {
          labels: {
            color: 'white'
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
