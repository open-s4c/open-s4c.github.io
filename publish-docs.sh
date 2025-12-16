#!/bin/sh
# Copyright (C) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# SPDX-License-Identifier: MIT

set -eu

usage() {
    cat <<'EOF'
Usage: $(basename "$0") (--version vX.Y.Z | --main) [--project NAME] [--docs-dir PATH] [--checkout-dir PATH] [--dry-run]

Options:
  --version vX.Y.Z    Publish under <project>/api/vX.Y.Z
  --main              Publish under <project>/api/main
  --project NAME      Project folder name under the pages repo (default: $PUBLISH_PROJECT or current directory name)
  --docs-dir PATH     Path to generated docs (default: ./doc/api)
  --checkout-dir PATH Directory to clone/update open-s4c.github.io (default: temp dir)
  --dry-run           Sync files but skip git commit/push
  -h, --help          Show this help
EOF
    exit 1
}

require_arg() {
    if [ $# -lt 1 ] || [ -z "$1" ]; then
        echo "Missing argument" >&2
        usage
    fi
}

scripts=$(dirname $(readlink -f $0))
genindex=${scripts}/gen-index.sh
version=""
publish_main=0
docs_dir=""
checkout_dir=""
repo_url="${PUBLISH_REPO_URL:-https://github.com/open-s4c/open-s4c.github.io.git}"
repo_branch="${PUBLISH_REPO_BRANCH:-main}"
project_name="${PUBLISH_PROJECT:-}"
dry_run=0
use_ssh=0

while [ $# -gt 0 ]; do
    case "$1" in
        --version)
            shift
            require_arg "$1"
            version="$1"
            ;;
        --main)
            publish_main=1
            ;;
        --docs-dir)
            shift
            require_arg "$1"
            docs_dir="$1"
            ;;
        --project)
            shift
            require_arg "$1"
            project_name="$1"
            ;;
        --checkout-dir)
            shift
            require_arg "$1"
            checkout_dir="$1"
            ;;
        --dry-run)
            dry_run=1
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage
            ;;
    esac
    shift
done

if [ -n "${version}" ] && [ "${publish_main}" -eq 1 ]; then
    echo "Use either --version or --main, not both" >&2
    usage
fi
if [ -z "${version}" ] && [ "${publish_main}" -eq 0 ]; then
    echo "One of --version or --main is required" >&2
    usage
fi
if [ -z "${project_name}" ]; then
	project_name="$(basename "$(pwd)")"
fi

if [ -z "${docs_dir}" ]; then
	docs_dir="$(pwd)/doc/api"
fi

pages_dir="${checkout_dir}"

if [ ! -d "${pages_dir}/.git" ]; then
	echo "error trying to open repo in ${pages_dir}"
	exit 1
fi

docdir="doc"
destdir="${pages_dir}/${project_name}"

#rm -rf "${destdir}"
mkdir -p "${destdir}"

echo "copy doc/"
for fn in $(ls ${docdir}/); do
	if [ "$fn" = "Doxyfile.in" ]; then
		continue
	fi
	fn="${docdir}/$fn"
	if [ -f "$fn" ]; then
		cp $fn ${destdir}/
	fi
	if [ -d $fn ] && [ "$fn" != "api" ]; then
		cp -r $fn ${destdir}
	fi
done

if [ "${publish_main}" -eq 1 ]; then
    version="main"
else
    version="${version}"
fi

if [ -d "${docdir}/api" ]; then
	echo "copy doc/api"
	# copy API version
	mkdir -p ${destdir}/api
	cp -r ${docdir}/api ${destdir}/api/${version}
	# update links
	(
		echo "update api links"
		cd ${destdir}
		for fn in $(ls *.md); do
			sed -i'' 's|doc/api|doc/api/'"${version}"'|g' $fn
		done
	)

	# generate index
	(
		echo "generate index"
		#cd ${destdir}/api
		#$genindex
	)
fi

exit
if command -v rsync >/dev/null 2>&1; then
    rsync -a --delete "${docs_dir}/" "${dest_dir}/"
else
    (cd "${docs_dir}" && find . -maxdepth 0 >/dev/null)
    cp -R "${docs_dir}/." "${dest_dir}/"
fi

if [ "${dry_run}" -eq 1 ]; then
    echo "[dry-run] Synced docs to ${dest_dir}; skipping commit/push"
    git -C "${pages_dir}" status
    exit 0
fi

cd "${pages_dir}"
git add "${target_path}"
if git diff --staged --quiet; then
    echo "No changes to publish."
    exit 0
fi

git commit -m "Publish vatomic docs ${target}"
git push origin "${repo_branch}"
