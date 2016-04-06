brew install \
    homebrew/php/php70 --with-phpdbg \
    homebrew/php/php70-intl

echo "date.timezone = 'Australia/Brisbane'" >> "$(brew --prefix)/etc/php/7.0/php.ini"
echo "phar.readonly = 0" >> "$(brew --prefix)/etc/php/7.0/php.ini"
echo "assert.exception = 1" >> "$(brew --prefix)/etc/php/7.0/php.ini"

curl -L "https://getcomposer.org/download/1.0.0/composer.phar" > "$HOME/bin/composer"
chmod +x "$HOME/bin/composer"
"$HOME/bin/composer" config --global -- sort-packages true
