#! /bin/sh

for py_version in 3.8 3.9 3.10 3.11 3.12; do
    py_path="$(dirname "$(uv python find "${py_version}")")"
    export PATH="${py_path}:$PATH"
done

if [ $# -ge 1 ]; then
    exec "$@"
else
    exec sh
fi
