# README
* Deployed app in heroku
```console
https://easy-flight-api.herokuapp.com/
```

* Deployed app in heroku (documentation)
```console
https://easy-flight-api.herokuapp.com/api-docs/index.html
```

* Ruby version
```console
ruby '3.1.2'
```

* Rails version
```console
gem 'rails', '~> 7.0.3'
```

* Configuration (exec)
```console
bundle install
```

* Required File
```console
.env
...................
PSQL_USER=
PSQL_PASSWORD=
JWT_SECRET=Secret
```

* Database creation
```console
rails db:create
```

* Database initialization
```console
rails db:migrate
rails db:seed
```

* How to run the test

*Database cleaner is not implemented, Capybara may fail the seat test when you repeat it.
```console
rspec
```

* How to run specific the test (* can be any file)
```console
rspec spec/requests/*
```

* Deployment instructions (required heroku login)
```console
git push heroku main
```

