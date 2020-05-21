##: init takes no parameters
##	This is only used for the very first initial setup.
##	Use bin/check afterwards.

x test -x bin/check && ERROR please use "$WORK/bin/check" instead

x IGN tty || ERROR this must be run from a TTY as it requires user interaction
x GITCLEAN "$WORK" || ERROR "$WORK:" git status not clean
# GITCLEAN "$MAIN" || ERROR "$MAIN:" git status not clean

NOTYET

