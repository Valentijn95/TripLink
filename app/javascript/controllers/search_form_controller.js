import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["bar", "input", "results"]

  connect() {

    }

  showSearchForm() {
    this.barTarget.classList.remove("d-none");
    this.barTarget.querySelector(".search-form-input").focus();
  }

  displaySearchResults(options) {
    this.resultsTarget.innerHTML = "";

    options.forEach((option) => {

      const address = option.properties.full_address;
      const li = document.createElement("li");
      li.innerHTML = address;
      li.classList.add("list-group-item");
      this.resultsTarget.appendChild(li);

      li.addEventListener("click", () => {
        this.inputTarget.value = address;
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
        this.displaySearchResults(data.features);
      });
  }
};
