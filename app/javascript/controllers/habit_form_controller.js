import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = [
    "step1", "step2", "step3", "step4", "step5",
    "categoryId", "habitTypeId", "habitTypeList",
    "unitDisplay", "verbId",
    "goalValue", "frequencySelect", "endTypeSelect",
    "dateContainer", "trackerSetup",
    "backButton", "closeButton"
  ];
  connect() {
    this.selectedCategoryId = null;
    this.selectedHabitTypeId = null;
    this.selectedUnit = null;
    this.selectedFrequency = null;
    if (this.hasFrequencySelectTarget) this.updateStep5();
    if (this.hasStep1Target) this.showStep(this.step1Target);
    const modalEl = this.element.closest(".modal");
    if (modalEl) {
      modalEl.addEventListener("hidden.bs.modal", () => {
        this.resetForm();
      });
    }

    this._boundKeydown = this._onKeydown.bind(this);
    document.addEventListener("keydown", this._boundKeydown);

    this.element.querySelectorAll(".form-control").forEach(input => {
      input.addEventListener("input", () => {
        if (input.value) {
          input.classList.add("filled");
        } else {
          input.classList.remove("filled");
        }
      });
    });

    const goalFields = this.element.querySelectorAll(".goal-field");
    goalFields.forEach(field => {
      field.style.justifyContent = "center";
      field.style.alignItems = "center";
    });

    if (this.hasFrequencySelectTarget) {
      this.frequencySelectTarget.querySelectorAll(".card-option").forEach(card => {
        card.addEventListener("click", () => {
          this.frequencySelectTarget.querySelectorAll(".card-option").forEach(c => c.classList.remove("selected"));
          card.classList.add("selected");

          const input = card.querySelector('input[type="radio"]');
          if (input) input.checked = true;
          input?.dispatchEvent(new Event('change', { bubbles: true }));
        });
      });
    }

    if (this.hasEndTypeSelectTarget) {
      this.endTypeSelectTarget.querySelectorAll(".card-option").forEach(card => {
        card.addEventListener("click", () => {
          this.endTypeSelectTarget.querySelectorAll(".card-option").forEach(c => c.classList.remove("selected"));
          card.classList.add("selected");

          const input = card.querySelector('input[type="radio"]');
          if (input) input.checked = true;
          input?.dispatchEvent(new Event('change', { bubbles: true }));
        });
      });
    }

  }

  disconnect() {
    document.removeEventListener("keydown", this._boundKeydown);
  }
  _onKeydown(e) {
    if (e.key === "Escape") {
      this.closeForm();
    }
  }
  closeForm(event) {
    if (event) event.preventDefault();
    const modalEl = this.element.closest(".modal");
    const modal = bootstrap.Modal.getInstance(modalEl);
    if (modal) modal.hide();
  }
  resetForm() {
    const form = this.element.closest("form");
    if (form) form.reset();
    if (this.hasCategoryIdTarget) this.categoryIdTarget.value = "";
    if (this.hasHabitTypeIdTarget) this.habitTypeIdTarget.value = "";
    if (this.hasVerbIdTarget) this.verbIdTarget.value = "";
    if (this.hasUnitDisplayTarget) this.unitDisplayTarget.textContent = "Unit";
    if (this.hasDateContainerTarget) this.dateContainerTarget.innerHTML = "";
    if (this.hasTrackerSetupTarget) this.trackerSetupTarget.innerHTML = "";
    this.element.querySelectorAll(".selected").forEach(el => el.classList.remove("selected"));
    if (this.hasStep1Target) this.showStep(this.step1Target);
  }
  nextStep(event) {
    if (event) event.preventDefault();
    const current = this.element.querySelector(".habit-form-step.active");
    if (!current) return;
    let next = current.nextElementSibling;
    while (next && !next.classList.contains("habit-form-step")) {
      next = next.nextElementSibling;
    }
    if (next) this.showStep(next);
  }
  prevStep(event) {
    if (event) event.preventDefault();
    const current = this.element.querySelector(".habit-form-step.active");
    if (!current) return;
    let prev = current.previousElementSibling;
    while (prev && !prev.classList.contains("habit-form-step")) {
      prev = prev.previousElementSibling;
    }
    if (prev) this.showStep(prev);
  }
  showStep(step) {
    this.element.querySelectorAll(".habit-form-step").forEach(s => s.classList.remove("active"));
    if (step && step.classList) step.classList.add("active");
    if (this.hasBackButtonTarget && this.hasStep1Target) {
      const isStep1 = (step === this.step1Target);
      this.backButtonTarget.style.display = isStep1 ? "none" : "inline-flex";
    }
  }
  // Step 1
  selectCategory(event) {
    if (!this.hasStep1Target) return;
    this.step1Target.querySelectorAll(".category-card").forEach(card => card.classList.remove("selected"));
    const card = event.currentTarget;
    card.classList.add("selected");
    this.selectedCategoryId = String(card.dataset.categoryId);
    if (this.hasCategoryIdTarget) this.categoryIdTarget.value = String(card.dataset.categoryId);
    this.filterHabitTypes();
    if (this.hasStep2Target) this.showStep(this.step2Target);
  }
  filterHabitTypes() {
    if (!this.hasHabitTypeListTarget) return;
    this.habitTypeListTarget.querySelectorAll(".habit-type-item").forEach(item => {
      item.style.display = (String(item.dataset.categoryId) === String(this.selectedCategoryId)) ? "flex" : "none";
    });
    this.habitTypeListTarget.scrollTop = 0;
  }
  // Step 2
  selectHabitType(event) {
    if (!this.hasHabitTypeListTarget) return;
    const item = event.currentTarget;
    this.habitTypeListTarget.querySelectorAll(".habit-type-item").forEach(i => i.classList.remove("selected"));
    item.classList.add("selected");
    this.selectedHabitTypeId = item.dataset.habitTypeId;
    if (this.hasHabitTypeIdTarget) this.habitTypeIdTarget.value = String(item.dataset.habitTypeId);
    this.selectedUnit = item.dataset.unit || null;
    if (this.hasUnitDisplayTarget) {
      this.unitDisplayTarget.textContent = this.selectedUnit || "Unit";
    }
    if (this.hasStep3Target) this.showStep(this.step3Target);
  }
  // Step 3
  selectVerb(event) {
    const card = event.currentTarget;
    if (this.hasStep3Target) this.step3Target.querySelectorAll(".verb-card").forEach(c => c.classList.remove("selected"));
    card.classList.add("selected");
    const verbId = card.dataset.verbId;
    if (this.hasVerbIdTarget) this.verbIdTarget.value = verbId;
    if (this.hasStep4Target) this.showStep(this.step4Target);
  }
  // Step 4
  frequencyChanged(event) {
    this.selectedFrequency = event.currentTarget.value;
    this.updateStep5();
  }
  endTypeChanged(event) {
    const type = event.currentTarget.value;
    const container = this.dateContainerTarget;
    container.innerHTML = "";

    if (type === "target_date") {
      const label = document.createElement("label");
      label.textContent = "Date cible";

      const input = document.createElement("input");
      input.type = "text";
      input.name = "habit[goal][target_day]";
      input.className = "form-control";

      container.appendChild(label);
      container.appendChild(input);

      flatpickr(input, {
        locale: "fr",
        dateFormat: "Y-m-d",
        altInput: true,           // Affiche 25/12/2024 au lieu de 2024-12-25
        altFormat: "d/m/Y",       // Format français pour l'utilisateur
        allowInput: true,
        disableMobile: true,
        firstDayOfWeek: 1         // Lundi en premier jour
      });

    } else if (type === "period") {
      const label = document.createElement("label");
      label.textContent = "Période";

      const inputRange = document.createElement("input");
      inputRange.type = "text";
      inputRange.className = "form-control mb-2";

      const inputStart = document.createElement("input");
      inputStart.type = "hidden";
      inputStart.name = "habit[goal][start_date]";

      const inputEnd = document.createElement("input");
      inputEnd.type = "hidden";
      inputEnd.name = "habit[goal][end_date]";

      container.appendChild(label);
      container.appendChild(inputRange);
      container.appendChild(inputStart);
      container.appendChild(inputEnd);

      flatpickr(inputRange, {
        mode: "range",
        dateFormat: "Y-m-d",
        allowInput: true,
        onChange: function(selectedDates) {
          if (selectedDates.length === 2) {
            inputStart.value = flatpickr.formatDate(selectedDates[0], "Y-m-d");
            inputEnd.value = flatpickr.formatDate(selectedDates[1], "Y-m-d");
          }
        }
      });
    }
  }


  updateStep5() {
    if (!this.hasTrackerSetupTarget) return;
    const trackerSetup = this.trackerSetupTarget;
    const frequencyRadio = this.frequencySelectTarget?.querySelector('input[type="radio"]:checked');
    const frequency = frequencyRadio ? frequencyRadio.value : null;

    trackerSetup.innerHTML = "";

    const reminderDiv = trackerSetup.querySelector(".form-check.form-switch");
    if (reminderDiv) {
      reminderDiv.style.width = "180px";
      reminderDiv.style.margin = "0 1rem";
      reminderDiv.parentElement.style.justifyContent = "center";
    }

    const reminderToggleHTML = `
      <div class="mb-3 text-center">
        <label class="d-block mb-2">Voulez-vous recevoir un rappel ?</label>
        <div class="d-flex align-items-center justify-content-center gap-3">
          <span class="reminder-label">Non</span>
          <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox"
                  name="habit[goal][tracking_config][reminder]"
                  data-action="change->habit-form#toggleReminder"
                  checked>
          </div>
          <span class="reminder-label">Oui</span>
        </div>
      </div>
    `;
    if (frequency === "daily") {
      trackerSetup.innerHTML = reminderToggleHTML;
    } else if (frequency === "weekly") {
      trackerSetup.innerHTML = `
        <div class="mb-3">
          <label>Quels jour(s) ?</label>
          <div class="weekdays-grid-4">
            ${["Lun","Mar","Mer","Jeu"].map(day => `
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="habit[goal][tracking_config][weekly_days][]" value="${day}">
                <label class="form-check-label">${day}</label>
              </div>
            `).join("")}
          </div>
          <div class="weekdays-grid-7 mt-2">
            ${["Ven","Sam","Dim"].map(day => `
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="habit[goal][tracking_config][weekly_days][]" value="${day}">
                <label class="form-check-label">${day}</label>
              </div>
            `).join("")}
          </div>
        </div>
        ${reminderToggleHTML}
      `;
    } else if (frequency === "monthly") {
      trackerSetup.innerHTML = `
        <div class="mb-3">
          <label>Combien de fois par mois ?</label>
          <input type="number" name="habit[goal][tracking_config][monthly_count]" min="1" max="30" class="form-control">
        </div>
        <div class="mb-3">
          <label>Quels jours de la semaine ?</label>
          <div class="weekdays-container">
            ${["Lun","Mar","Mer","Jeu","Ven","Sam","Dim"].map(day => `
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="habit[goal][tracking_config][monthly_days][]" value="${day}">
                <label class="form-check-label">${day}</label>
              </div>
            `).join("")}
          </div>
        </div>
        ${reminderToggleHTML}
      `;
    }
  }
  toggleReminder(event) {
    const isActive = event.target.checked
    this.reminderStatusTarget.innerHTML =
    `<strong class="fs-6">Rappel</strong><br>${isActive ? "Activé" : "Désactivé"}`
  }
}
