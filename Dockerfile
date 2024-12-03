# Rubyのイメージをとってくる
FROM ruby:3.1.0
# 必要なパッケージのインストール
RUN apt update -qq && apt install -y  nano vim iputils-ping net-tools nodejs

# いったん適当なところでbundle installしておく。
WORKDIR /app
ADD . /app

RUN gem install bundler
RUN gem update bundler
RUN bundle install -j4


