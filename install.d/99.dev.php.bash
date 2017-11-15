echo "date.timezone = 'Australia/Brisbane'" > "$(brew --prefix)/etc/php/7.1/php.ini"
echo "phar.readonly = 0" >> "$(brew --prefix)/etc/php/7.1/php.ini"
echo "assert.exception = 1" >> "$(brew --prefix)/etc/php/7.1/php.ini"

composer config --global -- sort-packages true
