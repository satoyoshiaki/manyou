# README



## テーブル名 :tasks
- task_name :string
- description :text


## Herokuデプロイ手順

#### 1,herokuにログイン

```
$ heroku login
```

#### 2,herokuにアプリ作成

```
$ heroku create
```

#### 3,precompile

```
$ rails assets:precompile
```

#### 4,herokuのbuildpackにrubyパッケージセット

```
$ heroku buildpacks:set heroku/ruby
```

#### 5,herokuのbuildpackにnodejsパッケージ追加

```
$ heroku buildpacks:add --index 1 heroku/nodejs
```

#### 6,masterにpush

```
$ git add .
$ git commit -m 'heroku'
$ git push origin master
```

#### 7,herokuへデプロイ

```
$ git push heroku master
```

#### 8,herokuでdb:migrate

```
$ heroku run rails db:migrate
```

#### 9,アプリを見に行く

```
$ heroku open
```




