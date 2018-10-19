PHP_INI_PATH="$(php --ini | grep "Loaded Configuration File" | cut -d: -f2)"

cat << EOF > ${PHP_INI_PATH}
date.timezone = 'Australia/Brisbane'
phar.readonly = 0
assert.exception = 1
EOF

composer config --global -- sort-packages true
