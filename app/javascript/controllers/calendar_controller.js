import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = ["container", "monthSelect", "yearSelect"]

  connect() {
    this.scrollToSelectedMonth()

    if (this.hasContainerTarget) {
      this.containerTarget.addEventListener("click", (e) => {
        const dayEl = e.target.closest(".calendar-day")
        if (!dayEl) return
        const date = dayEl.getAttribute("data-date")
        if (!date) return
        this.openTrackerModalForDate(date)
      })
    }
  }

  goToday() {
    const today = new Date()
    const year = today.getFullYear()
    const month = today.getMonth() + 1
    this.navigateTo(year, month, { scrollOnlyIfSameMonth: false })
  }

  changeMonth() {
    const year = parseInt(this.yearSelectTarget.value, 10)
    const month = parseInt(this.monthSelectTarget.value, 10)
    this.navigateTo(year, month, { scrollOnlyIfSameMonth: false })
  }

  changeYear() {
    const year = parseInt(this.yearSelectTarget.value, 10)
    const month = parseInt(this.monthSelectTarget.value, 10)
    this.navigateTo(year, month, { scrollOnlyIfSameMonth: false })
  }

  navigateTo(year, month, { scrollOnlyIfSameMonth = true } = {}) {
    const currentYear  = parseInt(this.element.dataset.calendarSelectedYear, 10)
    const currentMonth = parseInt(this.element.dataset.calendarSelectedMonth, 10)
    const same = (year === currentYear && month === currentMonth)

    if (!same || !scrollOnlyIfSameMonth) {
      const base = this.element.dataset.calendarIndexPath || "/calendar"
      const url = `${base}?year=${year}&month=${month}`
      Turbo.visit(url)
    } else {
      this.scrollToMonth(year, month)
    }
  }

  scrollToSelectedMonth() {
    const year  = this.element.dataset.calendarSelectedYear
    const month = String(this.element.dataset.calendarSelectedMonth).padStart(2, "0")
    if (!year || !month) return
    this.scrollToMonth(year, month)
  }

  scrollToMonth(year, month) {
    const id = `month-${year}-${String(month).padStart(2, "0")}`
    const el = document.getElementById(id)
    if (!el) return
    setTimeout(() => el.scrollIntoView({ behavior: "smooth", block: "center" }), 50)
  }

  openTrackerModalForDate(date) {
    const modalEl = document.getElementById("trackerFormModal")
    if (!modalEl) return
    const dateInput = modalEl.querySelector('input[name="date"]') || modalEl.querySelector('#tracker_date')
    if (dateInput) dateInput.value = date
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl)
    modal.show()
  }

  selectMonth(event) {
    event.preventDefault()
    const month = parseInt(event.currentTarget.dataset.value, 10)
    const year = parseInt(this.element.dataset.calendarSelectedYear, 10)
    const btn = this.monthSelectTarget
    btn.textContent = event.currentTarget.textContent
    this.navigateTo(year, month, { scrollOnlyIfSameMonth: false })
  }

  selectYear(event) {
    event.preventDefault()
    const year = parseInt(event.currentTarget.dataset.value, 10)
    const month = parseInt(this.element.dataset.calendarSelectedMonth, 10)
    const btn = this.yearSelectTarget
    btn.textContent = event.currentTarget.textContent
    this.navigateTo(year, month, { scrollOnlyIfSameMonth: false })
  }

}
