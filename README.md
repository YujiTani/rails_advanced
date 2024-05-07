# Blog

ブログシステム

## Ruby version

- See `.ruby-version`.

## Rails version

- See `Gemfile`.

## Node version

- See `.node-version`

## プロジェクトのセットアップ手順

### database.yml.defaultのコピー

```bash
cp config/database.yml.default config/database.yml
```

### Dockerを使った環境準備(イメージのビルド)

```bash
docker compose build
```

### railsサーバーの起動(バックグラウンドでのコンテナの立ち上げとrailsサーバーの起動)

```bash
docker compose up
```

### docker compose upを実行しているターミナルとは別に新しくターミナルを立ち上げてください。新しいターミナルにて以下のコマンドを実行してください。

### Gemのインストール

```bash
docker compose exec web bundle install
```

### node_modulesのインストール

```bash
docker compose exec web yarn install
```

### データベースの作成

```bash
docker compose exec web rails db:create
```

### マイグレーションファイルの適応

```bash
docker compose exec web rails db:migrate
```

### 初期データの入れ込み

```bash
docker compose exec web rails db:seed_fu
```

### CSS, JS用のサーバー起動(コンテナ内で実行してください・ターミナルで複数のタブを開くとやりやすいでしょう)

```
bin/dev
```

### Dockerコンテナの終了

```bash
docker compose down
```

### デバッグツールを使うときは

#### railsサーバーを立ち上げているコンテナの名前を確認する

```bash
docker ps
```

#### 該当のコンテナIDをattachする

```bash
docker attach コンテナ名
```

### 開発用管理画面ログイン方法(ブラウザで行います)

`localhost:3000/login_as/1` にアクセス
※ 1はユーザーIDなのでDBに入っているユーザーのIDによって異なることがあります。
