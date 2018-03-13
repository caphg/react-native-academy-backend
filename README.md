#### Description

This is a boilerplate code for starting a new rails 5 api project which assumes using the following:

 - Rails 5
 - Postgres DB
 - rspec
 - FactoryGirl
 - devise_token_auth

#### Token auth

Assumes controllers that will talk json and auth all requests via devise_token_auth gem which is set up for user model.
Rspec example on vehicles_controller sample has been done for illustration purposes.

#### Example resources

All resources are namespaced to `/api/v1`.

- Vehicles Controller
- Vehicle Model
- Vehicle Factory
- User Model
- User factory
- routes

#### Custom config

- smtp set to use for `MailCatcher` gem in development
- `current_user` and similar helper methods exist
- rspec has `json` method that parses the response from test requests
