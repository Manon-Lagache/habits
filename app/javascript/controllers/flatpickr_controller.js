import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    if (!this.hasInputTarget) return
    if (typeof window.flatpickr !== "function") {
      console.warn("flatpickr n'est pas chargé sur window. Vérifiez le CDN dans layouts/application.html.erb")
      return
    }
 
    this._instance = window.flatpickr(this.inputTarget, {
      mode: "range",
      dateFormat: "Y-m-d",
      allowInput: true
    })
  }

  disconnect() {
    if (this._instance) {
      try { this._instance.destroy() } catch(e) { /* noop */ }
      this._instance = null
    }
  }
}
