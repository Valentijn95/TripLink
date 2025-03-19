import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message"
export default class extends Controller {
  connect() {
    // scroll to element smoothly
    this.element.scrollIntoView({ behavior: 'smooth' });
  }
}
