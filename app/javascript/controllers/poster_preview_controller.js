import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "image", "instructions", "icon"]

  preview() {
    const file = this.inputTarget.files[0]

    if (file) {
      const reader = new FileReader()
      reader.onload = (e) => {
        this.imageTarget.src = e.target.result
        this.imageTarget.classList.remove("hidden")
        this.instructionsTarget.classList.add("hidden")
        this.iconTarget.classList.add("hidden")
      }
      reader.readAsDataURL(file)
    } else {
      this.resetPreview()
    }
  }

  resetPreview() {
    this.imageTarget.src = ""
    this.imageTarget.classList.add("hidden")
    this.instructionsTarget.classList.remove("hidden")
    this.iconTarget.classList.remove("hidden")
  }
}
