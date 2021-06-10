# observe_block

# 概要
ExplorerとBitcoinノードのブロックを比較して±3以上の差が生じた場合通知をするバッチ。

# 仕組み
![PXL_20210610_133942362](https://user-images.githubusercontent.com/16983252/121535378-13446f80-ca3d-11eb-9bbc-550bf61e9a5f.jpg)

1. RubyプロセスからExplorerのAPIを叩く
   - 利用API: https://blockchain.info/q/getblockcount
2. 同一コンピュータ内のbitcoidが起動しているdockerコンテナ内にアクセスしてnodeから情報を取得する
3. 1,2の結果を突合して通知を行う

# bitcoindの起動方法
下記手順でbitcoindが稼働するdockerインスタンスを作成した。

1. まずOSSのdocker-bitcoindをクローンする。
```shell
$ git clone https://github.com/kylemanna/docker-bitcoind
```

2. RestAPIを使いたいため1でクローンしたものから修正を加える
   https://github.com/kylemanna/docker-bitcoind/blob/master/bin/btc_init
   このファイルに`rest=1`の設定を追加する
   
3. docker buildする。
```shell
# ※--platformは自環境がarmチップであるためoption付与しているが、不要であれば消しても良い。
$ docker build -t bitcoind . --platform linux/amd64
```
4. docker run
```shell
$ docker run --platform linux/amd64 -v $HOME/bitcoin-data:/bitcoin --name=bitcoind-node -d \
   -p 8333:8333 \
   -p 127.0.0.1:8332:8332 \
   bitcoind
```

5. APIで情報が参照できるようになっている
```shell
$ curl http://localhost:8332/rest/chaininfo.json
```

その他
```shell
$ docker stop bitcoind-node # コンテナstop
$ docker exec -i -t bitcoind-node bash # コンテナのなかに入る

```


# cronでの起動について
このスクリプトはcronで定期実行する場合、crontabに下記のような記述をする必要がある
実行時間は適当な値を設定すると良い。
```shell
* * * * * bundle exec ruby /path/to/script_root/execute.rb
```
