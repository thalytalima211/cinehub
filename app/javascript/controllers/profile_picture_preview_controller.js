import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fileInput", "previewImg", "cameraButton"];

  connect() {
    this.cameraButtonTarget.addEventListener("click", () => this.fileInputTarget.click());
    this.fileInputTarget.addEventListener("change", (event) => this.updatePreview(event));
  }

  updatePreview(event) {
    const file = event.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (e) => {
      this.previewImgTarget.src = e.target.result;
    };
    reader.readAsDataURL(file);
  }
}
