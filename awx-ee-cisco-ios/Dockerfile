FROM quay.io/ansible/awx-ee:latest

# 必要なネットワークモジュールを追加
USER root
# 必要なPythonライブラリを追加
RUN pip install \
    netmiko \
    paramiko \
    scrapli \
    pyats \
    ansible-pylibssh \
    "ansible-core==2.17.*"
    
RUN ansible-galaxy collection install \
    -p /usr/share/ansible/collections \
    cisco.ios \
    cisco.nxos \
    cisco.asa \
    ansible.netcommon \
    ansible.utils

# ANSIBLE_COLLECTIONS_PATHS を指定（/usr/shareも含める）
ENV ANSIBLE_COLLECTIONS_PATHS=/usr/share/ansible/collections