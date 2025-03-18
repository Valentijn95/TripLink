// app/javascript/controllers/autocomplete_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input", "results"];

  connect() {
    console.log("Autocomplete controller connected!");
  }

  search() {
    const query = this.inputTarget.value;
    console.log("Search query:", query);

    if (query.length > 0) {
      fetch(`/interests/search?query=${query}`)
        .then(response => response.json())
        .then(data => {
          this.resultsTarget.innerHTML = data.interests.map(interest =>
            `<li data-id="${interest.id}">${interest.interest}</li>`
          ).join("");
        })
        .catch(error => {
          console.error("Error fetching interests:", error);
        });
    } else {
      this.resultsTarget.innerHTML = "";
    }
  }
}

