#!/bin/bash

apt-get -y update
apt-get -y install nfs-common
mkdir -p /mount/${nfs_storage_account_name}/${nfs_file_share_name}
mount -t nfs ${nfs_storage_account_name}.file.core.windows.net:/${nfs_storage_account_name}/${nfs_file_share_name} /mount/${nfs_storage_account_name}/${nfs_file_share_name} -o vers=4,minorversion=1,sec=sys
chown 8536:8536 /mount/${nfs_storage_account_name}/${nfs_file_share_name}