import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tracker-show"
export default class extends Controller {

  static values = {
    url: String

  }
  connect() {
  }

  decrement(event) {
    event.preventDefault();
    const input = event.currentTarget.closest(".tracker-show").querySelector("input[type='number']");
    input.stepDown();
    console.log(parseFloat(input.value))
  }



  increment(event) {
    event.preventDefault();
    const input = event.currentTarget.closest(".tracker-show").querySelector("input[type='number']");
    input.stepUp();
    this._fetch(input)
  }

  _fetch(input) {
    const form = input.closest('form')
    const formData = new FormData(form);
    fetch(this.urlValue, {
      method: "POST",
      headers: {
        'Accept': 'application/json'
      },
      body: formData
    })
   }
}
