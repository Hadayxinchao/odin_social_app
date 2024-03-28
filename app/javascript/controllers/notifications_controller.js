import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['notifications', 'symbol']

  toggle() {
    const div = this.notificationsTarget
    div.classList.toggle('show')
  }

  updateSeen() {
    const span = this.symbolTarget
    span.textContent = 'Notifications'
    span.classList.remove('notifications-unread')
  }
}