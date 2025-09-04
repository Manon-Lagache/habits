// app/javascript/controllers/counter_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["number"]
  static values = {
    end: Number,
    duration: { type: Number, default: 1200 },
    delay: { type: Number, default: 0 }
  }

  connect() {
    // Démarre l'animation après le délai spécifié
    setTimeout(() => {
      this.animate()
    }, this.delayValue)
  }

  animate() {
    const startValue = 0
    const endValue = this.endValue
    const duration = this.durationValue
    const startTime = performance.now()

    // Fonction d'easing pour un effet plus naturel
    const easeOutQuart = (t) => 1 - Math.pow(1 - t, 4)

    const updateCounter = (currentTime) => {
      const elapsed = currentTime - startTime
      const progress = Math.min(elapsed / duration, 1)

      // Applique l'easing
      const easedProgress = easeOutQuart(progress)

      // Calcule la valeur actuelle
      const currentValue = Math.floor(startValue + (endValue - startValue) * easedProgress)

      // Met à jour l'affichage
      this.numberTarget.textContent = currentValue

      // Ajoute une classe CSS pour l'effet visuel pendant l'animation
      this.numberTarget.classList.add('counting')

      // Continue l'animation si pas terminée
      if (progress < 1) {
        requestAnimationFrame(updateCounter)
      } else {
        // Animation terminée
        this.numberTarget.classList.remove('counting')
        this.numberTarget.classList.add('completed')

        // Déclenche un événement personnalisé
        this.dispatch('completed', { detail: { finalValue: endValue } })
      }
    }

    requestAnimationFrame(updateCounter)
  }

  // Méthode pour redémarrer l'animation
  restart() {
    this.numberTarget.textContent = "0"
    this.numberTarget.classList.remove('completed', 'counting')
    this.animate()
  }
}
