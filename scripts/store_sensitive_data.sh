#!/usr/bin/env zsh

gpg --export -a EB6A4FC927DE468CAD383BA8713D984F56881209 > pub.key
gpg --export-secret-key -a EB6A4FC927DE468CAD383BA8713D984F56881209 > priv.key

tar cf sensitive_data.tar ./pub.key ./priv.key
tar rf sensitive_data.tar -C ~ .netrc
tar rf sensitive_data.tar -C ~/.ssh id_rsa id_rsa.pub

gzip --keep -9 sensitive_data.tar
shred -vuz pub.key priv.key sensitive_data.tar
chmod 600 sensitive_data.tar.gz
ls -l sensitive_data.tar.gz

