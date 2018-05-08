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

Using [Bundler](https://github.com/bundler/bundler):

```shell
bundle
```

### Set environment variables

Using [Figaro](https://github.com/laserlemon/figaro):

See [config/application.yml.sample](https://github.com/huguesfranc/beeleev/blob/master/config/application.yml.sample) and see Heroku app settings (sensitive data).

### Initialize the database

```shell
bundle exec rake db:create db:migrate db:seed
```

### Add heroku remotes

Using [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli):

```shell
heroku git:remote -a beeleev
heroku git:remote --remote heroku-staging -a beeleev-staging
```

## Serve

```shell
bundle exec rails s
```

## Deploy

### With Heroku pipeline (recommended)

Push to Heroku staging remote:

```shell
git push heroku-staging
```

Go to the Heroku Dashboard and [promote the app to production](https://devcenter.heroku.com/articles/pipelines).

### Directly to production (not recommended)

Push to Heroku production remote:

```shell
git push heroku
```
