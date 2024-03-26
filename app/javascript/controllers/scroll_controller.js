import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
    document.addEventListener('turbo:frame-render', (event) => {
      var hash = window.location.hash.substring(1);
      if (hash != '') {
        var element = document.querySelector(`#${hash}`);
        if (element != null) {
          element.classList.add('scroll-into')
          element.scrollIntoView();
        }
      }
    })
  }
}