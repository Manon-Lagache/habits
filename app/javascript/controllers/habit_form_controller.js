import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "step1", "step2", "step3", "step4",
    "habitTypeList", "verbSelect", "unitDisplay",
    "goalValue", "reminderToggle", "reminderDetails",
    "frequencySelect", "endTypeSelect", "dateContainer", "trackerSetup"
  ];

  connect() {
    this.selectedCategoryId = null;
    this.selectedHabitTypeId = null;
    this.selectedUnit = null;
    this.selectedFrequency = null;

    this.updateStep4();
  }

  // step 1
  selectCategory(event) {
    if (!this.hasStep1Target) return;
    this.step1Target.querySelectorAll(".category-card").forEach(card => card.classList.remove("selected"));
    const card = event.currentTarget;
    card.classList.add("selected");
    this.selectedCategoryId = String(card.dataset.categoryId);
    this.filterHabitTypes();

    if (this.hasStep2Target) {
      this.showStep(this.step2Target);
    } else {
      console.error("step2Target introuvable !");
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
    this.selectedUnit = item.dataset.unit || null;

    if (this.hasUnitDisplayTarget) {
      this.unitDisplayTarget.textContent = this.selectedUnit || "Unit";
    }

    const verbsCSV = item.dataset.verbs || "";
    const verbs = verbsCSV.split(",").map(v => v.trim()).filter(Boolean);

    if (this.hasVerbSelectTarget) {
      this.verbSelectTarget.innerHTML = "";
      const promptOption = document.createElement("option");
      promptOption.text = "Choisir une action";
      promptOption.value = "";
      this.verbSelectTarget.add(promptOption);
      verbs.forEach(v => {
        const option = document.createElement("option");
        option.value = v;
        option.text = v;
        this.verbSelectTarget.add(option);
      });
    }
  }

  verbSelected(event) {
    const selectedVerb = event.currentTarget.value;
    if (selectedVerb && this.selectedHabitTypeId) {
      if (this.hasStep3Target) this.showStep(this.step3Target);
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
      label.textContent = "Choisir la période";
      const wrapper = document.createElement("div");
      wrapper.setAttribute("data-controller", "flatpickr");
      const input = document.createElement("input");
      input.type = "text";
      input.name = "habit[goal][period]";
      input.className = "form-control";
      input.setAttribute("data-flatpickr-target", "input");

      wrapper.appendChild(input);
      container.appendChild(label);
      container.appendChild(wrapper);
    } else {
    }
  }

  // Step 4
  updateStep4() {
    if (!this.hasTrackerSetupTarget) return;
    const frequency = this.frequencySelectTarget?.value;
    const trackerSetup = this.trackerSetupTarget;

    trackerSetup.innerHTML = "";

    if (frequency === "daily") {
      trackerSetup.innerHTML = `
        <div class="mb-3">
          <label>Voulez-vous recevoir un rappel ?</label>
          <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox"
                   data-action="change->habit-form#toggleReminder">
            <label class="form-check-label">Oui / Non</label>
          </div>
        </div>
        <div class="mb-3 reminder-time" style="display: none;">
          <label>Heure du rappel :</label>
          <input type="time" name="habit[reminder_time]" class="form-control">
        </div>
      `;
    }

    if (frequency === "weekly") {
      trackerSetup.innerHTML = `
        <div class="mb-3">
          <label>Quels jours de la semaine ?</label>
          <div class="d-flex flex-wrap gap-2">
            ${["Lun","Mar","Mer","Jeu","Ven","Sam","Dim"].map(day => `
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="habit[days][]" value="${day}">
                <label class="form-check-label">${day}</label>
              </div>
            `).join("")}
          </div>
        </div>

        <div class="mb-3">
          <label>Voulez-vous recevoir un rappel ?</label>
          <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox"
                   data-action="change->habit-form#toggleReminder">
            <label class="form-check-label">Oui / Non</label>
          </div>
        </div>
        <div class="mb-3 reminder-time" style="display: none;">
          <label>Heure du rappel :</label>
          <input type="time" name="habit[reminder_time]" class="form-control">
        </div>
      `;
    }

    if (frequency === "monthly") {
      trackerSetup.innerHTML = `
        <div class="mb-3">
          <label>Combien de fois par mois ?</label>
          <input type="number" min="1" max="30" name="habit[monthly_count]" class="form-control">
        </div>

        <div class="mb-3">
          <label>Quels jours de la semaine ?</label>
          <div class="d-flex flex-wrap gap-2">
            ${["Lun","Mar","Mer","Jeu","Ven","Sam","Dim"].map(day => `
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="habit[monthly_days][]" value="${day}">
                <label class="form-check-label">${day}</label>
              </div>
            `).join("")}
          </div>
        </div>
      `;
    }

  }

  toggleReminder(event) {
    const checkbox = event.target;
    const reminderTime = checkbox.closest(".form-check").parentElement.querySelector(".reminder-time");
    if (reminderTime) {
      reminderTime.style.display = checkbox.checked ? "block" : "none";
    }
  }
}
