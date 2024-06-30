# Pin npm packages by running ./bin/importmap

# Pin the application JavaScript file and preload it
pin "application", preload: true

# Pin Turbo Rails and preload it
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

# Pin Stimulus and preload it
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true

# Pin Stimulus loading and preload it
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# Pin all JavaScript files from the controllers directory under the "controllers" namespace
pin_all_from "app/javascript/controllers", under: "controllers"
