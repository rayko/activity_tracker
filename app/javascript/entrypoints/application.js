// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
// console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

// console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Rails stuff
import * as Turbo from '@hotwired/turbo'
import { Application } from '@hotwired/stimulus'
import { registerControllers } from 'stimulus-vite-helpers'
import * as ActionCable from '@rails/actioncable'
import * as ActiveStorage from '@rails/activestorage'
import '@rails/actiontext'
import 'trix'

Turbo.start()

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

const controllers = import.meta.glob('@controllers/**/*_controller.js', { eager: true })
registerControllers(application, controllers)

// Core Rails Frameworks

ActiveStorage.start()

// // Import all channels.
// const channels = import.meta.glob('./**/*_channel.js', { eager: true })

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

//import "@assets/images/boxTally5.svg"

import "@assets/stylesheets/tailwind.css"
import "@assets/stylesheets/default.sass"

function openDropDown(trigger) {
  const targetId = trigger.getAttribute("data-target-id");  
  const targetEl = document.getElementById(targetId);
  if (targetEl) {
    targetEl.classList.toggle("hidden");
    trigger.classList.toggle("bg-sky-600");
  }
}

document.addEventListener("turbo:load", function() {
  for (const triggerButton of document.getElementsByClassName("dropdown-trigger")) {
    triggerButton.addEventListener("click", () => {
      openDropDown(triggerButton);
    })
  }
});
