import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.onScroll = this.onScroll.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
    this.onScroll()
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
  }

  onScroll() {
    if (window.scrollY > 50) {
      this.element.classList.add("navbar-scrolled")
    } else {
      this.element.classList.remove("navbar-scrolled")
    }
  }
}
