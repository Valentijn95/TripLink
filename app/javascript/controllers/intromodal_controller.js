import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="intromodal"
export default class extends Controller {
  static targets = [ "canvas" ]

  connect() {
  }

  show() {
    console.log("showing canvas");
    this.canvasTarget.classList.remove("d-none");
  }

  close() {
    this.canvasTarget.classList.add("d-none");
  }
}
