#!/bin/sh
set -eu

FILES=$(ls *.md)
WHERE=$(basename $(pwd))
echo "# Index $WHERE"
echo
for F in $FILES; do
	name=$(basename $F .md)
	echo "- [$name]($F)"
done
