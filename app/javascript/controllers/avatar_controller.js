import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo"
export default class extends Controller {
  static targets = [ 'image', 'input' ]
  connect() {
    this.originalSource = this.imageTarget.src
  }

  preview() {
    this.element.removeChild(this.imageTarget)

    const files = this.inputTarget.files

    if (files.length === 0) {
      const image = document.createElement('img');
      image.setAttribute('data-photo-target', 'image')
      image.style.maxHeight = '90px';
      image.style.maxWidth = '90px';
      image.src = this.originalSource;
      this.element.appendChild(image);
    } else {
      const image = document.createElement('img');
      image.setAttribute('data-photo-target', 'image')
      image.style.maxHeight = '90px';
      image.style.maxWidth = '90px';
      image.src = URL.createObjectURL(files[0]);
      this.element.appendChild(image);
    }
  }
}
