#!/bin/bash

# Copyright 2023 Cloudera, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#####################################################
# User Data Bash script to setup suid proxy on a
# Amazon Linux 2 EC2 instance.
#
########################################################

# Install
yum update -y
yum install -y squid

# Generate self-signed cert
openssl req \
    -x509 -new -sha256 -nodes \
    -newkey rsa:2048 -days 365 \
    -keyout /etc/squid/private.key \
    -out /etc/squid/cert.pem \
    -subj "/C=GB/ST=London/L=London/O=Example/OU=Example/CN=example.com"

# Squid proxy configuration file
cat > /etc/squid/squid.conf << EOF
# Working Config File for non-transparent proxy
# Recommended minimum configuration:
#
# Example rule allowing access from your local networks.
# Adapt to list your (internal) IP networks from where browsing
# should be allowed
acl localnet src 0.0.0.1-0.255.255.255    # RFC 1122 "this" network (LAN)
acl localnet src 10.0.0.0/8        # RFC 1918 local private network (LAN)
acl localnet src 100.64.0.0/10        # RFC 6598 shared address space (CGN)
acl localnet src 169.254.0.0/16     # RFC 3927 link-local (directly plugged) machines
acl localnet src 172.16.0.0/12        # RFC 1918 local private network (LAN)
acl localnet src 192.168.0.0/16        # RFC 1918 local private network (LAN)
acl localnet src fc00::/7            # RFC 4193 local private network range
acl localnet src fe80::/10          # RFC 4291 link-local (directly plugged) machines
acl SSL_ports port 443
acl Safe_ports port 80        # http
acl Safe_ports port 21        # ftp
acl Safe_ports port 443        # https
acl Safe_ports port 70        # gopher
acl Safe_ports port 210        # wais
acl Safe_ports port 1025-65535    # unregistered ports
acl Safe_ports port 280        # http-mgmt
acl Safe_ports port 488        # gss-http
acl Safe_ports port 591        # filemaker
acl Safe_ports port 777        # multiling http

# ACL for the whitelist
acl http-whitelist dstdomain "/etc/squid/whitelist.txt"

# Deny access to URLs not in the whitelist
http_access allow http-whitelist

http_port 3129 cert=/etc/squid/cert.pem key=/etc/squid/private.key
https_port 3129 cert=/etc/squid/cert.pem key=/etc/squid/private.key
ssl_bump bump all
sslcrtd_program /usr/lib/squid/ssl_crtd -s /var/lib/ssl_db -M 4MB
sslcrtd_children 8 startup=1 idle=1

# Deny access to all other URLs
http_access deny all

# Recommended minimum Access Permission configuration:
# Deny requests to certain unsafe ports
http_access deny !Safe_ports


# Deny CONNECT to other than secure SSL ports
http_access deny CONNECT !SSL_ports


# Only allow cachemgr access from localhost
http_access allow localhost manager
http_access deny manager


# This default configuration only allows localhost requests because a more
# permissive Squid installation could introduce new attack vectors into the
# network by proxying external TCP connections to unprotected services.


http_access allow localhost


# The two deny rules below are unnecessary in this default configuration
# because they are followed by a "deny all" rule. However, they may become
# critically important when you start allowing external requests below them.
# Protect web applications running on the same server as Squid. They often
# assume that only local users can access them at "localhost" ports.
http_access deny to_localhost
# Protect cloud servers that provide local users with sensitive info about
# their server via certain well-known link-local (a.k.a. APIPA) addresses.
http_access deny to_linklocal
#
# INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
#
#http_access allow whitelist_url
# For example, to allow access from your local networks, you may uncomment the
# following rule (and/or add rules that match your definition of "local"):
# http_access allow localnet
# And finally deny all other access to this proxy
#http_access deny all


http_access allow all
# Squid normally listens to port 3128
# Squid normally listens to port 3128
http_port 3128
# Uncomment and adjust the following to add a disk cache directory.
#cache_dir ufs /var/spool/squid 100 16 256
# Leave coredumps in the first cache dir
coredump_dir /var/spool/squid
#
# Add any of your own refresh_pattern entries above these.
#
refresh_pattern ^ftp:        1440    20%    10080
refresh_pattern ^gopher:    1440    0%    1440
refresh_pattern -i (/cgi-bin/|\?) 0    0%    0
refresh_pattern .        0    20%    4320

EOF

# Genearte whitelist file
cat > /etc/squid/whitelist.txt << EOF
# TEST VAR cdp_region is ${cdp_region}

.v2.us-west-1.ccm.cdp.cloudera.com
dbusapi.us-west-1.sigma.altus.cloudera.com
cloudera-dbus-prod.s3.amazonaws.com

archive.cloudera.com
api.us-west-1.cdp.cloudera.com
cloudera-service-delivery-cache.s3.amazonaws.com
container.repository.cloudera.com
docker.repository.cloudera.com

prod-us-west-2-starport-layer-bucket.s3.us-west-2.amazonaws.com
s3-r-w.us-west-2.amazonaws.com
.execute-api.us-west-2.amazonaws.com
.s3.us-west-1.amazonaws.com
console.us-west-1.cdp.cloudera.com

pypi.org
raw.githubusercontent.com
github.com
#eks.*.amazonaws.com
# Added after
s3.amazonaws.com
EOF

# Start and enable squid
systemctl enable squid
systemctl start squid