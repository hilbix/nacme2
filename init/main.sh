##: init takes no parameters
##	This is only used for the very first initial setup.
##	Use bin/check afterwards.

x test -x bin/check && ERROR please use "$WORK/bin/check" instead

x IGN tty || ERROR this must be run from a TTY as it requires user interaction
CLEAN "$WORK" || ERROR "$WORK:" git status not clean
#CLEAN "$MAIN" || ERROR "$MAIN:" git status not clean

if	x ign git status
then
	:
fi

NOTYET

