// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "channels"
import "@popperjs/core"
import "bootstrap"

import SearchFormController from "./controllers/search_form_controller.js"
Stimulus.register("search-form", SearchFormController)
