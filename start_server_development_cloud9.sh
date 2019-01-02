#!/bin/bash -x

export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

export RAILS_ENV=development



# 開発サーバ起動
bundle exec rails s -b $IP -p $PORT
