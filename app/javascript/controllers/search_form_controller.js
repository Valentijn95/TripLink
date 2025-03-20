import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["bar", "input", "results", "city"]

  connect() {

    }

  showSearchForm() {
    this.barTarget.classList.remove("d-none");
    this.barTarget.querySelector(".search-form-input").focus();
  }

  displaySearchResults(suggestions) {
    console.log(suggestions);
    this.resultsTarget.innerHTML = "";

    suggestions.forEach((suggestion) => {

      const city = suggestion.context.place.name;
      const address = suggestion.address;
      const name = suggestion.name;
      const li = document.createElement("li");
      li.innerHTML = `${name} - ${address}, ${suggestion.context.place.name}`;
      li.classList.add("list-group-item");
      this.resultsTarget.appendChild(li);

      li.addEventListener("click", () => {
        console.log(city);
        this.resultsTarget.innerHTML = "";
        this.inputTarget.value = address;
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
