# Beeleev

[beeleev.com](https://www.beeleev.com)

## Install

### Clone the repository

```shell
git clone git@github.com:huguesfranc/beeleev.git
cd beeleev
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.2.3`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.2.3
```

### Install dependencies

Using [bundler](https://github.com/bundler/bundler):

```shell
bundle
```

### Set environment variables

Contact the developer: [contact@juliendargelos.com](mailto:contact@juliendargelos.com) (sensitive data).

### Initialize the database

```shell
rake db:create db:migrate db:seed
```

### Add the production remote

Using [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli):

```shell
heroku git:remote -a beeleev
```

## Serve

```shell
rails s
```

## Deploy

```shell
git push heroku
```
