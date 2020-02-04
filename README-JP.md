# docker-simple-dovecot

docker-simple-dovecotは、シンプルなIMAPサーバーのDockerイメージです。ローカル環境でMaildirディレクトリに受信メールを格納できるようにしました。

## 使用方法

イメージをビルドします。

    docker build -t dovecot .

.env.defaultを.envにコピーして、自分の環境に合わせて設定してください。

    cp .env.default .env

とりあえず以下のコマンドでコンテナを起動します。

    docker run -it -p 143:143 --env-file .env dovecot /bin/bash

Docker Hubにあるイメージを使った起動方法は次の通りです。以下の例では、メールを格納するホームディレクトリを/srv/mail/homeのボリュームにアタッチしています。

    docker run -d -v /srv/mail/home:/home -p 143:143 --env-file .env muneando/dovecot




