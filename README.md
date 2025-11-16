# ee-builder
Quick build for AWX EE.

ee-builder はansible builder より手軽にEE をビルドし、container repositry に登録するためのスクリプトです。  
container resistry ではなく、microk8s のコンテナに登録することも可能。

## 使い方
作成するコンテナイメージ名を決定し、コンテナイメージ名のディレクトリを作成しDockerfile をコピーする。  
build_adnd_register.sh を開き、下記の項目を適宜修正する。
```
RESISTER_NAME
(sample : 192.168.1.8, domain name or IP address)

RESISTRY_NAME
(sample : library, repository name in container registry)
```
Dockerfile に必要なライブラリを記載したり、ansible のライブラリを記載する。

コンテナレジストリに登録せずに、microk8s に登録する場合は、build_and_register.sh の RESISTRY 変数をmicrok8sに変更する。

※podman を前提にスクリプトは書いているが、docker を利用する場合は、script のpodman コマンドを"sudo docker" などに変更すれば実行可能。

---

### 動機
オフライン環境（Proxy 環境で外部との通信に申請が必要）で動作するAWX/container resistry(harbor) のために、WSL2でビルドしたイメージをAWXで利用できるようにするため。