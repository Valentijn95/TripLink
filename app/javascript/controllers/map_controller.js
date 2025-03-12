import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }


  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/satellite-streets-v12',
      center: [0, 0],
      zoom: 0.9
    })
    this.#addMarkersToMap();
    // this.#fitMapToMarkers();
  }

  async loadLocationDetails(location, guides) {
    console.log("loadlocationdetails");
    const guideIds = guides.map(g => g.id).join(",");
    const url = `search?id=${location.id}&guide_ids=${guideIds}`;
    //const url = "search"
    const response = await fetch(url, {
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    });

    if (response.ok) {
      const html = await response.text();
      Turbo.renderStreamMessage(html);
    }
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      console.log(marker.marker_data)
      const pin = new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
      pin.getElement().addEventListener('click', () => {
        this.loadLocationDetails(marker.marker_data.location, marker.marker_data.guides);
      });
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 10, duration: 4000 })
  }
}
