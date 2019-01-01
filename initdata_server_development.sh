#!/bin/bash -x
source /etc/profile.d/rbenv.sh

export RAILS_ENV=development
bundle exec rails db:seed
