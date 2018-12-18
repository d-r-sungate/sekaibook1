#!/bin/bash -x
source /etc/profile.d/rbenv.sh

export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

export RAILS_ENV=development



# 開発サーバ起動
bundle exec rails s -b 0.0.0.0

