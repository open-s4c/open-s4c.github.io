#!/bin/sh
set -eu

FILES=$(ls *.md)
WHERE=$(basename $(pwd))
OUTPUT=README.md
echo "# Index $WHERE" > $OUTPUT
echo >> $OUTPUT
for F in $FILES; do
	name=$(basename $F .md)
	if [ "$name" = "README" ]; then
		continue
	fi
	echo "- [$name]($F)"
done >> $OUTPUT
