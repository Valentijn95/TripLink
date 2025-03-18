import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"


// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }


  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address"
    })

    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/viti95/cm8a9pull00fg01s38ky96654',
      center: [0, -80],
      zoom: 0.7
    })
    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }



  async loadPartial(location, guides) {
    const guideIds = guides.join(",");
    const url = `search?id=${location}&guide_ids=${guideIds}`;
    console.log(url);
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
      const pin = new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
      pin.getElement().addEventListener('click', () => {
        console.log(marker.marker_data.guides);
        this.loadPartial(marker.marker_data.location, marker.marker_data.guides);
      });
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 10, duration: 4000 })
  }
}
