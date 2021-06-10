# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: cargo-git.eclass
# @MAINTAINER:
# parona@protonmail.com
# @AUTHOR:
# Alfred Wingate <parona@protonmail.com>
# @SUPPORTED_EAPIS: 7
# @BLURB: extend cargo.eclass to support git dependencies

case "${EAPI:-0}" in
	0|1|2|3|4|5|6)
		die "Unsupported EAPI=${EAPI:-0} (too old) for ${ECLASS}"
		;;
	7)
		;;
	*)
		die "Unsupported EAPI=${EAPI} (unknown) for ${ECLASS}"
		;;
esac

inherit cargo git-r3

EXPORT_FUNCTIONS src_unpack

# @ECLASS-VARIABLE: CARGO_GIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array with the syntax "repourl oid identifier" (still not sure where the oid comes from :/)
# Fetches the repo with git-r3 and then checksout them for cargo in ECARGO_HOME
# Several checkouts arent possible at this moment, only one checkout per repository.

# @FUNCTION: cargo-git_src_unpack
# @DESCRIPTION:
# Fetches and checksout git repositories specified in CARGO_GIT and sets up correct file structure for cargo so that it wont try to break the network sandbox
cargo-git_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	for line in "${CARGO_GIT[@]}"; do
		local giturl oid identifier
		read -r giturl oid identifier <<< "${line}"

		git-r3_fetch "${giturl}" "${identifier}"
	done

	cargo_src_unpack

	ECARGO_GIT="${ECARGO_HOME}/git"

	for line in "${CARGO_GIT[@]}"; do
		local giturl oid identifier
		read -r giturl oid identifier <<< "${line}"

		name=$(basename "${giturl}" .git || die)
		repodir=$(get_gitdir "${giturl}" || die)
		shortid=$(git --git-dir="${repodir}" rev-parse --short "${identifier}" || die)

		git clone --bare "${repodir}"  "${ECARGO_GIT}/db/${name}-${oid}" || die

		mkdir -p "${ECARGO_GIT}/checkouts/${name}-${oid}/${shortid}" || die
		git-r3_checkout "${giturl}" "${ECARGO_GIT}/checkouts/${name}-${oid}/${shortid}"

		# Make cargo happy with the checkout so that it doesnt try to update it
		touch "${ECARGO_GIT}/checkouts/${name}-${oid}/${shortid}/.cargo-ok" || die
	done
}

# @FUNCTION: get_gitdir
# @DESCRIPTION:
# Ripped out from git-r3.eclass to get the correct dir
get_gitdir() {
	debug-print-function ${FUNCNAME} "$@"

	local repo_name=${1#*://*/}

	# strip the trailing slash
	repo_name=${repo_name%/}

	# strip common prefixes to make paths more likely to match
	# e.g. git://X/Y.git vs https://X/git/Y.git
	# (but just one of the prefixes)
	case "${repo_name}" in
		# gnome.org... who else?
		browse/*) repo_name=${repo_name#browse/};;
		# cgit can proxy requests to git
		cgit/*) repo_name=${repo_name#cgit/};;
		# pretty common
		git/*) repo_name=${repo_name#git/};;
		# gentoo.org
		gitroot/*) repo_name=${repo_name#gitroot/};;
		# sourceforge
		p/*) repo_name=${repo_name#p/};;
		# kernel.org
		pub/scm/*) repo_name=${repo_name#pub/scm/};;
	esac
	# ensure a .git suffix, same reason
	repo_name=${repo_name%.git}.git
	# now replace all the slashes
	repo_name=${repo_name//\//_}

	echo "${EGIT3_STORE_DIR}/${repo_name}"
}
