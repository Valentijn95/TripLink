import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { timeout: Number }

  connect() {
    const timeout = this.timeoutValue || 3000;

    setTimeout(() => {
      this.element.style.transition = "opacity 1s ease";
      this.element.style.opacity = "0";
      setTimeout(() => {
        this.element.remove();
      }, 1000);
    }, timeout);
  }
}
