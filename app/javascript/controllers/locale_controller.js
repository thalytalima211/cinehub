import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dropdown", "button", "link"]

  connect() {
    document.addEventListener("click", this.outsideClick.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.outsideClick.bind(this))
  }

  toggle() {
    this.dropdownTarget.classList.toggle("hidden")
  }

  select(event) {
    event.preventDefault()
    const locale = event.currentTarget.dataset.locale

    document.cookie = `locale=${locale}; path=/; max-age=${60*60*24*365}`

    window.location.reload()
  }

  outsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.dropdownTarget.classList.add("hidden")
    }
  }
}
