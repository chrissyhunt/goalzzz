# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship - User has many Goals, etc.
- [x] Include at least one belongs_to relationship - Reflection belongs to Result, etc.
- [x] Include at least one has_many through relationship - User has many Results through Goals
- [x] The "through" part of the has_many through includes at least one user submittable attribute - User submits date for Result
- [x] Include reasonable validations for simple model objects - User validates presence of name, email, password, and uniqueness of email; Goal also has several validations
- [x] Include a class level ActiveRecord scope method - See completed Goals (/goals/completed)
- [x] Include a nested form writing to an associated model using a custom attribute writer - Result form also creates/edits Reflection
- [x] Include signup (how e.g. Devise)
- [x] Include login (how e.g. Devise)
- [x] Include logout (how e.g. Devise)
- [x] Include third party signup/login - Omniauth Facebook
- [x] Include nested resource show or index - /goals/:id/results/:id
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients) - /goals/:id/results/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
