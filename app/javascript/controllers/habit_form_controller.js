import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "step1", "step2", "step3", "step4", "categoryId", "habitTypeId",
    "habitTypeList", "verbSelect", "unitDisplay", "verbId",
    "goalValue", "reminderToggle", "reminderDetails",
    "frequencySelect", "endTypeSelect", "dateContainer", "trackerSetup"
  ];

  connect() {
    this.selectedCategoryId = null;
    this.selectedHabitTypeId = null;
    this.selectedUnit = null;
    this.selectedFrequency = null;

    if (this.hasFrequencySelectTarget) {
      this.updateStep4();
    }
  }


  // step 1
  selectCategory(event) {
    if (!this.hasStep1Target) return;
    this.step1Target.querySelectorAll(".category-card").forEach(card => card.classList.remove("selected"));
    const card = event.currentTarget;
    card.classList.add("selected");

    this.selectedCategoryId = String(card.dataset.categoryId);
    this.categoryIdTarget.value = String(card.dataset.categoryId);

    this.filterHabitTypes();

    if (this.hasStep2Target) {
      this.showStep(this.step2Target);
    }
  }

  filterHabitTypes() {
    if (!this.hasHabitTypeListTarget) return;
    this.habitTypeListTarget.querySelectorAll(".habit-type-item").forEach(item => {
      item.style.display = (String(item.dataset.categoryId) === String(this.selectedCategoryId)) ? "flex" : "none";
    });

    this.habitTypeListTarget.scrollTop = 0;
  }

  nextStep(event) {
    if (event) event.preventDefault();
    const current = event?.currentTarget?.closest?.(".habit-form-step");
    const next = current?.nextElementSibling;
    if (next) this.showStep(next);
  }

  prevStep(event) {
    if (event) event.preventDefault();
    const current = event?.currentTarget?.closest?.(".habit-form-step");
    const prev = current?.previousElementSibling;
    if (prev) this.showStep(prev);
  }

  showStep(step) {
    this.element.querySelectorAll(".habit-form-step").forEach(s => s.classList.remove("active"));
    if (step && step.classList) step.classList.add("active");
  }

  // Step 2
  selectHabitType(event) {
    if (!this.hasHabitTypeListTarget) return;
    const item = event.currentTarget;
    this.habitTypeListTarget.querySelectorAll(".habit-type-item").forEach(i => i.classList.remove("selected"));
    item.classList.add("selected");

    this.selectedHabitTypeId = item.dataset.habitTypeId;
    this.habitTypeIdTarget.value = String(item.dataset.habitTypeId);
    this.selectedUnit = item.dataset.unit || null;

    if (this.hasUnitDisplayTarget) {
      this.unitDisplayTarget.textContent = this.selectedUnit || "Unit";
      this.unitDisplayTarget.value = String(this.selectedUnit);
    }

  }

  verbSelected(event) {
    if (this.hasStep3Target) {
      this.step3Target.classList.add("active")
      this.element.querySelectorAll(".habit-form-step").forEach(step => {
        if (step !== this.step3Target) step.classList.remove("active")
      })
    }
  }


  // step 3
  frequencyChanged(event) {
    this.selectedFrequency = event.currentTarget.value;
    this.updateStep4();
  }

  endTypeChanged(event) {
    const type = event.currentTarget.value;
    const container = this.dateContainerTarget;
    container.innerHTML = "";

    if (type === "target_date") {
      const label = document.createElement("label");
      label.textContent = "Date cible";
      const input = document.createElement("input");
      input.type = "date";
      input.name = "habit[goal][target_date]";
      input.className = "form-control";
      container.appendChild(label);
      container.appendChild(input);
    } else if (type === "period") {
      const label = document.createElement("label");
      label.textContent = "Période";
      // const wrapper = document.createElement("div");
      const inputStart = document.createElement("input");
      // wrapper.setAttribute("data-controller", "flatpickr");
      // const input = document.createElement("input");
      // input.type = "text";
      // input.name = "habit[goal][period]";
      inputStart.type = "date";
      inputStart.name = "habit[goal][start_date]";
      inputStart.className = "form-control";
      const inputEnd = document.createElement("input");
      inputEnd.type = "date";
      inputEnd.name = "habit[goal][end_date]";
      inputEnd.className = "form-control";
      // input.className = "form-control";
      // input.setAttribute("data-flatpickr-target", "input");

      // wrapper.appendChild(input);
      // container.appendChild(label);
      // container.appendChild(wrapper);
      container.appendChild(label);
      container.appendChild(inputStart);
      container.appendChild(inputEnd);
    }
  }

  // Step 4
  updateStep4() {
    
    if (!this.hasTrackerSetupTarget) return;
    const trackerSetup = this.trackerSetupTarget;
    const frequency = this.frequencySelectTarget?.value;

    trackerSetup.innerHTML = "";


    const reminderToggleHTML = `
      <div class="mb-3">
        <label>Voulez-vous recevoir un rappel ?</label>
        <div class="form-check form-switch">
          <input class="form-check-input" type="checkbox"
                name="habit[goal][tracking_config][reminder]"
                data-action="change->habit-form#toggleReminder"
                value="true">
          <label class="form-check-label">Oui / Non</label>
        </div>
      </div>
    `;

    if (frequency === "daily") {
      trackerSetup.innerHTML = reminderToggleHTML;
    }

    if (frequency === "weekly") {
      trackerSetup.innerHTML = `
        <div class="mb-3">
          <label>Quels jour(s) ?</label>
          <div class="d-flex flex-wrap gap-2">
            ${["Lun","Mar","Mer","Jeu","Ven","Sam","Dim"].map(day => `
              <div class="form-check">
                // <input class="form-check-input" type="checkbox" name="habit[days][]" value="${day}">
                <input class="form-check-input" type="checkbox" name="habit[goal][tracking_config][weekly_days][]" value="${day}">
                <label class="form-check-label">${day}</label>
              </div>
            `).join("")}
          </div>
        </div>
        ${reminderToggleHTML}
      `;
    }

    if (frequency === "monthly") {
      trackerSetup.innerHTML = `
        <div class="mb-3">
          <label>Combien de fois par mois ?</label>
          <input type="number" name="habit[goal][tracking_config][monthly_count]" min="1" max="30" class="form-control">
        </div>

        <div class="mb-3">
          <label>Quels jours de la semaine ?</label>
          <div class="d-flex flex-wrap gap-2">
            ${["Lun","Mar","Mer","Jeu","Ven","Sam","Dim"].map(day => `
              <div class="form-check">
                // <input class="form-check-input" type="checkbox" name="habit[monthly_days][]" value="${day}">
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
    console.log("Reminder toggled:", event.target.checked);
  }
}



