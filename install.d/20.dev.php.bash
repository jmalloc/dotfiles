echo "date.timezone = 'Australia/Brisbane'" > "$(brew --prefix)/etc/php/7.1/php.ini"
echo "phar.readonly = 0" >> "$(brew --prefix)/etc/php/7.1/php.ini"
echo "assert.exception = 1" >> "$(brew --prefix)/etc/php/7.1/php.ini"

if [ ! -e "$HOME/bin/composer" ]; then
    curl -L "https://getcomposer.org/download/1.0.0/composer.phar" > "$HOME/bin/composer"
    chmod +x "$HOME/bin/composer"
fi

"$HOME/bin/composer" self-update
"$HOME/bin/composer" config --global -- sort-packages true
