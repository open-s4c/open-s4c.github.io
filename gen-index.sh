#!/bin/sh
set -eu

WHERE=$(basename $(pwd))
OUTPUT=README.md
echo "# Index $WHERE" > $OUTPUT
echo >> $OUTPUT

FILES=$(ls *.md)
for F in $FILES; do
	name=$(basename $F .md)
	if [ "$name" = "README" ]; then
		continue
	fi
	echo "- [$name]($F)"
done >> $OUTPUT

depth=2
done=false
while [ $done = false ]; do
	for dir in $(find . -maxdepth $depth -name "README.md"); do
		if [ "$dir" = "./README.md" ]; then
			continue
		fi
		dir=$(dirname $dir)
		echo "- [$dir]($dir)"
		done=true
	done
	depth=$(echo "$depth + 1" | bc )
done >> $OUTPUT
