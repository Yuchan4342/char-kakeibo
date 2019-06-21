# char-kakeibo / 家計簿

## Desctiption / 家計簿とは?
Web application to register and watch what you have bought and how much you have paid.  
日頃の買ったものと金額を登録して見ることができる Web アプリです。

### Features / 主な機能
- 買ったもの・収入などとその金額の登録/閲覧/更新/削除
- カテゴリー(費目)の追加・削除
- カテゴリー別のデータの表示・集計
  - 集計: 表示されている表データの収入・支出の合計を計算して表示
- 月ごと/年間のデータの表示・集計
- ユーザ・ログイン機能

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
