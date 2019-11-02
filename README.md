# back-end-api
The back-end for the SaaS platform

* Ruby version
  * Ruby: `2.6.5`
  * Create and use the gemset: `rvm use 2.6.5@devq [--create]`
  * Rails: `6.0.0`

* System dependencies
  * `MySQL`

* Configuration
  ```
  cp config/samples/local_env.yml config
  ```
  Update `config/local_env.yml` with your corresponding values

* Database creation & initialization
  * `rails db:setup`

* Run application locally
  * `rails s`
  * check it: `localhost:3000`

* Swagger API
  * `localhost:3000/docs/admin`
