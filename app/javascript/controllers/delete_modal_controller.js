import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "deleteForm", "cancelButton"];

  connect() {
    this.cancelButtonTarget.addEventListener("click", () => this.hideModal());

    this.modalTarget.addEventListener("click", (e) => {
      if (e.target === this.modalTarget) this.hideModal();
    });

    document.querySelectorAll("[id^='delete-button-']").forEach(button => {
      button.addEventListener("click", (e) => this.showModal(e, button));
    });
  }

  showModal(event, button) {
    event.preventDefault();
    const movieId = button.dataset.movieId;
    this.deleteFormTarget.action = `/movies/${movieId}`;
    this.modalTarget.classList.remove("hidden");
  }

  hideModal() {
    this.modalTarget.classList.add("hidden");
  }
}
