import { Application } from "@hotwired/stimulus"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import "@hotwired/turbo-rails"

window.Stimulus = Application.start()
eagerLoadControllersFrom("controllers", Stimulus)



