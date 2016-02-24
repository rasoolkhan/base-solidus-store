# A base Solidus store.

Extensions:
* solidus_auth_devise
* solidus_gateway
* solidus_virtual_gift_card
* spree_chimpy
* spree_static_content

Extras:
* travis-ci (ci integration)
* Dockerfile + run script

### Environment variables

Ensure that the following environment variables are set prior to application execution:
```
The below are examples only:

export STORE_NAME=base-store-solidus
export MYSQL_DB_PASSWORD=1234qwer
export MYSQL_DB_HOST=127.0.0.1
These are utilised in config/database.yml

# Spree Chimpy (Mailchimp)
exort MAILCHIMP_API_KEY=2ccd3a737e0232723af024235799c848c5-us10
This is set in config/initializers/spree_chimpy.rb

```

### Install dependancies

```
bundle
```

### Create Database

```
RAILS_ENV=(development|test|production) bundle exec rake db:create
```

### Run Migrations & Create admin user

```
RAILS_ENV=(development|test|production) bundle exec rake db:migrate
RAILS_ENV=(development|test|production) bundle exec rake spree_auth:admin:create
```

### Seed data & Load samples

(skip this step if you want to start with a clean installation)

```
RAILS_ENV=(development|test|production) bundle exec rake db:seed
RAILS_ENV=(development|test|production) bundle exec rake spree_sample:load
```

### Start

```
If all environment variables are set run:
bundle exec unicorn -p 8080 -c config/unicorn.rb

or alternatively utilize some of the rake task available as follows:

./go start:development
./go start:test
./go start:prod
Note: If using these tasks please see below the information on using dotenv
```

### View

```
open http://127.0.0.1:8080/

```

### DotEnv

This repository now uses dotenv to load all required environment variables from a local user .env file, this is .gitignore'd
and linked to a local file system location. This proves to be handy for development purposes when using the same set of environment variables repeatedly
```
ln -s ~/.spreeenv/.env .env

```

### Spree Static Content

This repo has each of the required migrations to use the spree_static_content gem already committed.
To reinstall/rerun the installation of spree static content use the following command:
```
bundle exec rails g spree_static_content:install
```
Once these migrations are run (required for when bootstrapping your db for the first time) this gem facilitates the creation static pages in the solidus admin console.
Note: All images referenced on static content pages can be stored in public/images (not referenced in .gitignore).

### Travis-ci

See .travis.yml for configuration. This repository is set to run a travisci job on commit

### Dockerfile + run script.

In order to package this repo as a Docker image see - Dockerfile. This builds from a 'base-vivid' image which has been built with all base system dependancies required.
This image can be run using the following syntax:

```
sudo docker run --name solidus -p 127.0.0.1:{{ app_port }}:{{ app_port }} --env-file ./env.list --link {{ mysql_name }}:mysql -d {{ store_image_name }}

As you can see the above assumes you are linking to a mysql container
The above also requires the existence of a ./env.list file which should take the following format:

MAILCHIMP_API_KEY={{ lookup('env','MAILCHIMP_API_KEY') }}
MYSQL_DB_PASSWORD={{ db_password }}
MYSQL_DB_HOST={{ mysql_name }}
STORE_NAME={{ store_name }}
MODE={{ mode }}
DOCKER_USER={{ docker_user }}
STORE_APP_ROOT={{ store_app_root }}
APP_PORT={{ app_port }}
BOOTSTRAP={{ bootstrap_spree }}

Note: I think it goes without saying but replace the above with your settings! The above is an extract from a jinja template used to generate these details on the fly...
```
