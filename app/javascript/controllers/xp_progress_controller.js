import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bar"]
  static values = { progress: Number }

  connect() {
    this.animateProgressBar()
  }

  animateProgressBar() {
    // Reset la barre à 0%
    this.barTarget.style.width = "0%"

    // Force un reflow pour s'assurer que le reset est appliqué
    this.barTarget.offsetHeight

    // Anime vers la valeur cible après un court délai
    requestAnimationFrame(() => {
      setTimeout(() => {
        this.barTarget.style.width = `${this.progressValue}%`
      }, 200)
    })
  }

  // Méthode pour mettre à jour dynamiquement (utile pour Turbo)
  progressValueChanged() {
    if (this.hasBarTarget) {
      this.animateProgressBar()
    }
  }
}
