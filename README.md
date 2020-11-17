# setup

まずはクローンします
`git clone git@github.com:team-dogenzaka/ichioshi.git`

dbはpostgresqlなので必要であれば

`brew install postgresql`

install完了後 postgresqlを起動します。

`brew services start postgresql`

フロントエンドの資産はyarnで管理しているのでyarnも入れます

`brew install yarn`

yarnのインストール完了後、必要なパッケージをインストールします。

`yarn install`

必要なgemをインストール

`bundle install`

ichioshi用のdbをセットアップします

`rails db:setup`

# start

`rails s`

## sslで起動

オレオレ証明書の暗号化キーを共有してもらい

`.cert/`配下に設置

pumaで一度設定を読み込むためにpumaコマンドで一度起動する（必要ない気もする)

`bundle exec puma -C config/puma.rb`

httpsで接続できることを確認

`https://127.0.0.1:9292/`

> この接続ではプライバシーが保護されませんのchromeのエラーが出たら、
> 詳細情報を表示から `~にアクセスする（安全ではありません）`をクリックして続ける。
> `~にアクセスする（安全ではありません）` が表示されなかった場合はその画面で
> `thisisunsafe`とキーボードでタイプすると接続できる

pumaの設定が読み込めればそれ以降

`rails s`で起動できます。

# credentials

秘匿情報の管理にmulti environment credentialsを採用しています。

> 参考：http://saku.hatenadiary.com/entry/2019/11/05/093755

環境毎の鍵を共有してもらい

`EDITOR=vi bundle exec rails credentials:edit --environment development`

で編集、確認ができます。



