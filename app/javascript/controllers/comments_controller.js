import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['postComments', 'commentSymbol']

  toggle() {
    const div1 = this.postCommentsTarget
    div1.classList.toggle('display-block')
    const div2 = this.commentSymbolTarget
    div2.classList.toggle('comment-symbol-active')
  }
}