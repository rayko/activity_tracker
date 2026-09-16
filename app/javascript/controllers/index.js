// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)


// Not sure if this is actually needed, the line above does that already?
// import { registerControllers } from 'stimulus-vite-helpers'
// // Automatically import and register all controllers inside this directory
// const controllers = import.meta.glob('./**/*_controller.js', { eager: true })
// registerControllers(application, controllers)
