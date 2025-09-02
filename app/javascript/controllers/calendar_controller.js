import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    this.scrollToSelectedMonth()

    this.element.addEventListener("click", (e) => {
      const dayEl = e.target.closest(".calendar-day")
      if (!dayEl) return
      const date = dayEl.dataset.date
      if (!date) return
      this.openTrackerModalForDate(date)
    })
  }

  scrollToSelectedMonth() {
    const year  = this.element.dataset.calendarSelectedYear
    const month = String(this.element.dataset.calendarSelectedMonth).padStart(2, "0")
    if (!year || !month) return
    const id = `month-${year}-${month}`
    const el = document.getElementById(id)
    if (el) {
      setTimeout(() => el.scrollIntoView({ behavior: "smooth", block: "center" }), 50)
    }
  }

  openTrackerModalForDate(date) {
    const modalEl = document.getElementById("trackerFormModal")
    if (!modalEl) return

    const dateInput = modalEl.querySelector('input[name="date"]') || modalEl.querySelector('#tracker_date')
    if (dateInput) dateInput.value = date

    const modal = bootstrap.Modal.getOrCreateInstance(modalEl)
    modal.show()
  }
}
