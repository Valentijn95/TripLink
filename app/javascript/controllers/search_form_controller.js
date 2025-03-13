import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["bar"]

  connect() {
    console.log("search_form_controller connected");
  }

  showSearchForm(event) {
    console.log(this.barTarget);
    this.barTarget.classList.remove("d-none");
  }

};
