import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  decrement(event) {
    event.preventDefault();
    const input = event.currentTarget.closest(".tracker-card").querySelector("input[type='number']");
    input.stepDown();
  }



  increment(event) {
    event.preventDefault();
    const input = event.currentTarget.closest(".tracker-card").querySelector("input[type='number']");
    input.stepUp();
  }
}
