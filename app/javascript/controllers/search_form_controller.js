import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["bar"]

  connect() {
    console.log("search_form_controller connected");
  }

  showSearchForm() {
    this.barTarget.classList.remove("d-none");
    this.barTarget.querySelector(".search-form-input").focus();
  }

};
