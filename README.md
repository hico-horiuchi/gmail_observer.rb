gmail_observer.rb
=================
Gmailを監視し，未読メールがある場合はGrowlで通知する．

初回起動時
----------
    $ gem install bundler
    $ bundle install --path=vendor/bundler

使用方法
--------
    $ ./gmail_observer.rb

設定
----
configディレクトリの.sampleファイルをコピーして使用する．
+ setting.yml
  - `gmail`
    - `account`: Gmailのアカウント(メールアドレス)．
    - `password`: Gmailのパスワード．
  - `growl` (Growlで通知しない場合は削除)
    - `appname`: 登録するアプリケーション名．
    - `host`: 通知先のIPアドレスまたはFQDN．
    - `password`: Growlのパスワード(設定している場合)．
    - `port`: 通知先のポート番号．Growlのデフォルトは23053．

アイコン: [IKONS](http://ikons.piotrkwiatkowski.co.uk/)
