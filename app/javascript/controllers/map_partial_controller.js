import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map-partial"
export default class extends Controller {
  connect() {
    console.log("MapPartialController connected")
  }

  close() {
    console.log("close");
    this.removePartial();
  }

  async removePartial() {
    console.log("removePartial");
    const url = "search/delete";
    const response = await fetch(url, {
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    });

    if (response.ok) {
      const html = await response.text();
      console.log(html);
      Turbo.renderStreamMessage(html);
    }
  }
}
