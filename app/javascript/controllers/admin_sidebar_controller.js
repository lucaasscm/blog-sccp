import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "backdrop"]

  connect() {
    this.close = this.close.bind(this)
    document.addEventListener("turbo:visit", this.close)
  }

  disconnect() {
    document.removeEventListener("turbo:visit", this.close)
  }

  toggle() {
    this.sidebarTarget.classList.toggle("-translate-x-full")
    this.backdropTarget.classList.toggle("hidden")
  }

  close() {
    this.sidebarTarget.classList.add("-translate-x-full")
    this.backdropTarget.classList.add("hidden")
  }
}
