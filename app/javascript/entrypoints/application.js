// Rails stuff
import * as Turbo from '@hotwired/turbo'
import { Application } from '@hotwired/stimulus'
import { registerControllers } from 'stimulus-vite-helpers'

Turbo.start()

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

const controllers = import.meta.glob('@controllers/**/*_controller.js', { eager: true })
registerControllers(application, controllers)

import "@assets/stylesheets/tailwind.css"
import "@assets/stylesheets/default.sass"

function openDropDown(trigger) {
  const targetId = trigger.getAttribute("data-target-id");
  const targetEl = document.getElementById(targetId);
  if (targetEl) {
    targetEl.classList.toggle("hidden");
    trigger.classList.toggle("bg-sky-600");
    trigger.classList.toggle("rounded-sm");
  }
}

document.addEventListener("turbo:load", function() {
  for (const triggerButton of document.getElementsByClassName("dropdown-trigger")) {
    triggerButton.addEventListener("click", () => {
      openDropDown(triggerButton);
    })
  }
});
