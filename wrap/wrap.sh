#!/bin/bash
# Initial shell wrapper
#
# Either: ln -s --relative wrap.sh /path/to/script/COMMAND[.sh]
# Or:     exec "$(readlink -e wrap.sh)" COMMAND args..

MAIN="$(readlink -e -- "$0")" || exit		# /path/to/work/nacme2/wrap/wrap.sh
MAIN="${MAIN%/*}"				# /path/to/work/nacme2/wrap

# See https://github.com/hilbix/bashy/blob/inc/boilerplate.inc
# We use a local copy as we want this to be self-contained.
. "$MAIN/boilerplate.inc" NACME2 || exit	# /path/to/work/nacme2/wrap/b*.inc

# nacme2 is a direct (but perhaps renamed) submodule of the work directory
MAIN="${MAIN%/*}"				# /path/to/work/nacme2
WORK="${MAIN%/*}"				# /path/to/work
# Requirement: "$WORK" is a different "git" than "$MAIN"
# "$MAIN" and "$WORK" are automanaged directories and automanaged GITs.
# "$WORK/.git" is not required, so it can be a non-toplevel-submodule.
# Stay flexible here.  Everything is checked with CMD=check

#
# Common things
#

ERROR() { CALLER 0; DEBUG "$file:" line "$line" "$@"; OOPS command "$CMD": "$@"; }	# ERROR ...: command errors
IGN() { Writer /dev/null "$@"; }	# IGN cmd args..: ignore output

# Check that the git status is clean (no unchanged commits, etc.)
GITCLEAN() { local s; s="$(cd -- "${1:-.}" && git status --porcelain)" && [ -z "$s" ]; }

#
# Invoked CMD always runs relative to "$WORK"
#

v CMD basename -- "$0" .sh
[ wrap != "$CMD" ] || { CMD="$1" && shift; } || OOPS Usage: "$0" COMMAND args..

o cd "$WORK"

EDGE="$MAIN/$CMD"
[ -d "$EDGE" ] && [ -s "$EDGE/main.sh" ] || OOPS unknown COMMAND: "$CMD"

. "$EDGE/main.sh"

