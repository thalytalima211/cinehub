import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["search", "suggestions", "item", "selected", "hidden"]
  static values = { multiple: Boolean }

  connect() {
    this.selectedIds = []

    this.selectedTarget.querySelectorAll("span[data-id]").forEach(span => {
      const id = span.dataset.id
      this.selectedIds.push(id)
    })

    this.updateHiddenInputs()
  }

  filter() {
    const value = this.searchTarget.value.toLowerCase()
    let hasMatch = false

    this.itemTargets.forEach(item => {
      const match = item.textContent.toLowerCase().includes(value)
      item.classList.toggle("hidden", !match)
      hasMatch ||= match
    })

    this.suggestionsTarget.classList.toggle("hidden", !hasMatch)
  }

  select(event) {
    const item = event.currentTarget
    const id = item.dataset.id
    const name = item.textContent.trim()

    if (this.multipleValue) {
      if (!this.selectedIds.includes(id)) {
        this.selectedIds.push(id)
        this.addTagElement(id, name)
        this.updateHiddenInputs()
      }
      this.searchTarget.value = ""
    } else {
      this.searchTarget.value = name
      this.hiddenTarget.innerHTML = `<input type="hidden" name="movie[tag_ids][]" value="${id}">`
      this.selectedIds = [id]
    }

    this.suggestionsTarget.classList.add("hidden")
  }

  addTagElement(id, name) {
    if (this.selectedTarget.querySelector(`[data-id='${id}']`)) return

    const tagEl = document.createElement("span")
    tagEl.className = "bg-sky-600 text-white px-2 py-1 rounded-md text-sm flex items-center gap-1"
    tagEl.dataset.id = id
    tagEl.innerHTML = `${name} <button type="button" data-action="select-suggestions#remove" data-id="${id}" class="text-white hover:text-red-400">×</button>`
    this.selectedTarget.appendChild(tagEl)
  }

  remove(event) {
    const id = event.target.dataset.id
    this.selectedIds = this.selectedIds.filter(x => x !== id)
    event.target.parentElement.remove()
    this.updateHiddenInputs()
  }

  updateHiddenInputs() {
    this.hiddenTarget.innerHTML = ""
    this.selectedIds.forEach(id => {
      const input = document.createElement("input")
      input.type = "hidden"
      input.name = "movie[tag_ids][]"
      input.value = id
      this.hiddenTarget.appendChild(input)
    })
  }

  hideIfOutside(event) {
    if (
      !event.target.closest(`[data-select-suggestions-target="search"]`) &&
      !event.target.closest(`[data-select-suggestions-target="suggestions"]`)
    ) {
      this.suggestionsTarget.classList.add("hidden")
    }
  }
}
