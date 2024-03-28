import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['notifications']

  connect() {
    console.log('connected')
  }

  toggle() {
    const div = this.notificationsTarget
    div.classList.toggle('show')
  }
}