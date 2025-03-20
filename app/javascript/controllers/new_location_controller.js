import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-location"
export default class extends Controller {

  static targets = [ "canvas", "input", "results", "name" ]

  connect() {
    console.log("new location controller connected");
  }

  show() {
    this.canvasTarget.classList.remove("d-none");
  }

  close() {
    this.canvasTarget.classList.add("d-none");
  }

  displaySearchResults(suggestions) {
    console.log(suggestions);
    this.resultsTarget.innerHTML = "";
    suggestions.forEach((suggestion) => {
      let name = "";

      if (suggestion.name_preferred) {
        name = suggestion.name_preferred;
      } else {
        name = suggestion.name;
      }
      console.log(name);
      const input = `${suggestion.name} - ${suggestion.address}, ${suggestion.context.place.name}`;
      // console.log(suggestion);
      const li = document.createElement("li");
      li.innerHTML = input;
      li.classList.add("list-group-item");
      this.resultsTarget.appendChild(li);

      li.addEventListener("click", () => {
        this.resultsTarget.innerHTML = "";
        this.inputTarget.value = input;
        this.nameTarget.value = name;
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
        //console.log(data)
      });
  }
}
