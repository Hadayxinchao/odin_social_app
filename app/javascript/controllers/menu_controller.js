import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['menu']

  toggle() {
    const div = this.menuTarget;
    div.classList.toggle('show');
  }
}