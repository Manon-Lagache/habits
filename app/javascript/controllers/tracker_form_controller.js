import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  stopPropagation(event) {
    event.stopPropagation()
  }

  increment(event) {
    const input = event.currentTarget.closest(".tracker-card").querySelector("input.tracker-input")
    let value = parseInt(input.value || 0, 10)
    input.value = value + 1
  }

  decrement(event) {
    const input = event.currentTarget.closest(".tracker-card").querySelector("input.tracker-input")
    let value = parseInt(input.value || 0, 10)
    if (value > 0) input.value = value - 1
  }
}
