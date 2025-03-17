import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash-notice"
export default class extends Controller {
  static targets = ["button"]

  static values = {
    active : String
  }

  connect() {
    console.log("Flash Notice Controller Connected");

    console.log(this.activeValue);
    console.log(this.buttonTarget);

    if (this.activeValue == "active") {
      this.buttonTarget.click();
    }
  }
}
