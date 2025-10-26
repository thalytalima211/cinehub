import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["filename"]

  update(event) {
    const fileName = event.target.files[0]?.name || "<%= t('movie_import.select_csv') %>"
    this.filenameTarget.textContent = fileName
  }
}
