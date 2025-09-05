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

    document.addEventListener("turbo:before-stream-render", (e) => {
      const template = e.target.querySelector("template")
      if (!template) return
      const modalEl = template.content.querySelector("#dayModal")
      if (!modalEl) return

      if (window.bootstrap && bootstrap.Modal) {
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl)
        modal.show()
      } else {
        modalEl.classList.add('show')
        modalEl.style.display = 'block'
      }
    })

  }

  selectMonth(event) {
    event.preventDefault()
    const month = parseInt(event.currentTarget.dataset.value, 10)
    const year  = parseInt(this.element.dataset.calendarSelectedYear, 10)
    if (this.hasMonthSelectTarget) {
      this.monthSelectTarget.textContent = event.currentTarget.textContent.trim()
    }
    this.navigateTo(year, month, { scrollOnlyIfSameMonth: false })
  }

  selectYear(event) {
    event.preventDefault()
    const year  = parseInt(event.currentTarget.dataset.value, 10)
    const month = parseInt(this.element.dataset.calendarSelectedMonth, 10)
    if (this.hasYearSelectTarget) {
      this.yearSelectTarget.textContent = String(year)
    }
    this.navigateTo(year, month, { scrollOnlyIfSameMonth: false })
  }

  goToday() {
    const today = new Date()
    const year = today.getFullYear()
    const month = today.getMonth() + 1
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
    console.log("Ouverture modal pour la date:", date) 
    const base = this.element.dataset.calendarIndexPath || "/calendar"
    const url = `${base}/day?date=${encodeURIComponent(date)}`
    fetch(url, {
      method: "GET",
      credentials: "same-origin",
      headers: {
        "Accept": "text/vnd.turbo-stream.html"
      }
    })
      .then((r) => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`)
        return r.text()
      })
      .then((html) => {
        Turbo.renderStreamMessage(html)
      })
      .catch((err) => {
        console.error("Erreur fetch /calendar/day :", err)
      })
  }
}
