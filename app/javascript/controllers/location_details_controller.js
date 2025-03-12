import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location-details"
export default class extends Controller {
  connect() {
    console.log("location details connected");
  }

  closeLocationDetails() {
    console.log("closeLocationDetails");
    this.removeLocationDetails();
  }

  async removeLocationDetails() {
    const response = await fetch("search/delete", {
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    });

    if (response.ok) {
      const html = await response.text();
      Turbo.renderStreamMessage(html);
    }
  }

}
