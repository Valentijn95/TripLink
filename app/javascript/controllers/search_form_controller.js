import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["bar", "input", "results", "city"]

  connect() {

    }

  showSearchForm() {
    this.barTarget.classList.remove("d-none");
    this.barTarget.querySelector(".search-form-input").focus();
  }

  makeOption(name, location) {
    const option =
      `<li class="list-group-item">
        <div class="d-flex flex-column align-items-start justify-content-center">
          <span>${name}</span>
          <span>${location}</span>
        </div>
      </li>`;
    return option;
  }

  displaySearchResults(suggestions) {
    this.resultsTarget.innerHTML = ""; // Clear the results
    if (suggestions[0].context.place == undefined && suggestions[0].feature_type == "place") {
      this.cityTarget.value = suggestions[0].name;
    } else {
      this.cityTarget.value = suggestions[0].context.place.name;
    }

    suggestions.forEach((suggestion) => {
      console.log("name: ", suggestion.name);
      let city;
      if (suggestion.context.place == undefined && suggestion.feature_type == "place") {
        city = suggestion.name;
      } else {
        city = suggestion.context.place.name;
      }


      const area = suggestion.place_formatted;
      const name = suggestion.name;

      const li = document.createElement("li");
      li.classList.add("list-group-item");
      li.innerHTML = `<div class="d-flex flex-column align-items-start justify-content-center">
                        <span><strong>${name}</strong></span>
                        <span>${area}</span>
                      </div>`;
      this.resultsTarget.appendChild(li);

      li.addEventListener("click", () => {
        this.resultsTarget.innerHTML = "";
        this.inputTarget.value = name + ", " + area;
        this.cityTarget.value = city;
        this.inputTarget.focus();
      });
      // console.log(options);
    });
  }

  fetchSearchResults(event) {
    const query = event.target.value;
    // event.preventDefault();
    //const query = event.target.querySelector(".search-form-input").value;
    const url = `api/autocomplete?query=${query}`;
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        this.displaySearchResults(data.suggestions);
      });
  }
};
