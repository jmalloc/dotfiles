if ! type -t realpath > /dev/null; then
    realpath() {
        local path="$1"

        if [[ "$path" != /* ]]; then
            path="$(pwd)/$path"
        fi

        if [ -d "$path" ]; then
            path="$(cd "$path"; pwd)"
        else
            path="$(cd "$(dirname "$path")"; pwd)/$(basename "$path")"
        fi

        while [ -L "$path" ]; do
            path="$(readlink "$path")"
        done

        if [ -d "$path" ]; then
            echo "$(cd "$path"; pwd)"
        else
            echo "$(cd "$(dirname "$path")"; pwd)/$(basename "$path")"
        fi
    }

    export -f realpath
fi
