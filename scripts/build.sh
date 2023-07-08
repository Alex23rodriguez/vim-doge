#!/usr/bin/env bash

# For more info about the 'set' command, see
# https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin
set -e
set -u

ROOT_DIR=$(cd "$(dirname "$0")/.."; pwd -P)
OUTFILE="${1:-}"

cd $ROOT_DIR
[[ ! -d ./bin ]] && mkdir ./bin
[[ -e ./bin/vim-doge ]] && rm -f ./bin/vim-doge

# Build the binary.
cd $ROOT_DIR/helper
cargo build --release
cp target/release/vim-doge-helper $ROOT_DIR/bin/
cd $ROOT_DIR

# Archive the binary.
if [[ "$OUTFILE" != "" ]]; then
  OUTFILE="$OUTFILE.tar.gz"
  cd $ROOT_DIR/bin
  rm -f ./*.tar.gz
  echo "==> Archiving $ROOT_DIR/bin/vim-doge -> $ROOT_DIR/bin/$OUTFILE"
  tar -czf "$OUTFILE" vim-doge-helper
fi

echo "🎉  Done building vim-doge-helper"
