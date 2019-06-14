# char-kakeibo / 家計簿

## Desctiption / 家計簿とは?
Web application to register and watch what you have bought and how much you have paid.  
日頃の買ったものと値段を登録して見ることができる Web アプリです。

## To start / 始め方
Install bundler and gems.  
bundler と gem をインストールします。
```
gem install bundler
bundle install --path vendor/bundle
```
Create database(PostgreSQL) and start server.  
データベース(PostgreSQL)を作成してサーバを起動します。
```
bundle exec rails db:create
bundle exec rails s
```
