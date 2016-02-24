#!/usr/bin/env bash

gem source --add https://rubygems.org/
gem list | grep bundler > /dev/null || gem install bundler --user-install --no-rdoc --no-ri --version "1.10.6"
bundle check > /dev/null || bundle install --path=vendor

bundle exec rake -f Rakefile $@
