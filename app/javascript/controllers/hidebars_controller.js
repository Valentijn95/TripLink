import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hidebars"
export default class extends Controller {
  connect() {
    console.log("Hello from hidebars_controller.js")
    window.addEventListener("load",function() {
      // Set a timeout...
      setTimeout(function(){
         // Hide the address bar!
         window.scrollTo(0, 1);
      }, 0);
   });
  }
}
