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
        data: userResultats.user.map(resultat => ({ x: resultat.event, y: resultat.score })),
        fill: true,
        backgroundColor: 'rgba(75, 100, 192, 0.2)',
        borderColor: 'rgba(75, 100, 192, 1)',
        borderWidth: 1
      }
    ];

    // Check if user_compare data exists
    if (userResultats.user_compare && userResultats.user_compare.length > 0) {
      const userCompareName = JSON.parse(this.data.get("userCompareName")); // Parse userStats as JSON

      datasets.push({
        label: userCompareName,
        data: userResultats.user_compare.map(resultat => ({ x: resultat.event, y: resultat.score })),
        fill: true,
        backgroundColor: 'rgba(240, 128, 128, 0.2)',
        borderColor: 'rgba(240, 128, 128, 1)',
        borderWidth: 1
      });
    } else {
      // Add an empty dataset for user_compare if it doesn't exist or has no elements
      datasets.push({
        label: "",
        data: [],
        fill: true,
        backgroundColor: 'rgba(0, 0, 0, 0)', // Set background color to transparent
        borderColor: 'rgba(0, 0, 0, 0)', // Set border color to transparent
        borderWidth: 0 // Set border width to 0
      });
    }

    const combinedDates = [...userResultats.user.map(resultat => resultat.event)]; // Initialize with user dates

    if (userResultats.user_compare && userResultats.user_compare.length > 0) {
      combinedDates.push(...userResultats.user_compare.map(resultat => resultat.event)); // Combine user_compare dates
    }

    const uniqueDates = Array.from(new Set(combinedDates)); // Remove duplicate dates
    uniqueDates.sort(); // Sort the dates in ascending order

    const data = {
      labels: uniqueDates,
      datasets: datasets
    };

    const options = {
      scales: {
        x: {
          beginAtZero: true,
          ticks: {
            color: 'white'
          }
        },
        y: {
          beginAtZero: true,
          ticks: {
            color: 'white'
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
      tooltips: {
        mode: 'index',
        intersect: false,
        backgroundColor: 'rgba(0, 0, 0, 0.8)',
        titleFontColor: 'white',
        bodyFontColor: 'white',
        footerFontColor: 'white'
      }
    };

    new Chart(ctx, {
      type: 'line',
      data: data,
      options: options
    });
  }
}
