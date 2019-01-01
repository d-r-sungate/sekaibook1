#!/bin/bash -x
source /etc/profile.d/rbenv.sh
export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

bundle install

export RAILS_ENV=development



export SECRET_KEY_BASE=`rake secret`
rake secret>.secret
bundle exec rails db:setup
bundle exec rails db:migrate

