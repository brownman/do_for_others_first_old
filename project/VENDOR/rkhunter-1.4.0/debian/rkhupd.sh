#!/bin/sh
set -e

if ! grep -qsE '^DISABLE_TESTS=.*(hashes.*attributes|attributes.*hashes|properties)' /etc/rkhunter.conf{.local,} || \
     grep -qsE '^ENABLE_TESTS=.*(hashes|attributes|properties)' /etc/rkhunter.conf{.local,}; then
         rkhunter --propupd --nolog
fi
