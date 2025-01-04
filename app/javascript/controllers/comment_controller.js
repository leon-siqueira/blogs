import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  connect() {
    document.addEventListener("trix-file-accept", (e) => {
      e.preventDefault()
    })
  }
}
