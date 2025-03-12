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
      zoom: 1
    })
    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }

  getInfoForLocationModal(locationId) {
    fetch(`api/locations/${locationId}`)
      .then(response => response.json())
      .then((data) => {
        console.log(data);
      });
  }
  openModal() {
    console.log("open modal");
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup({ offset: 25 }).setText(
        `This location has and id of: ${marker.location_id}`
      );
      const pin = new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        //.setPopup(popup)
        .addTo(this.map)
      pin.getElement().addEventListener("click", () => {
        this.getInfoForLocationModal(marker.location_id);
        this.openModal()
      });
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 4000 })
  }
}
