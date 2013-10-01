#!/bin/sh

SUBJECT='UPS Alert'
MESSAGE=''

case $1 in
    onbatt)
        MESSAGE='UPS is now on battery'
        ;;
    lowbatt)
        MESSAGE='UPS battery is low, shutdown soon'
        ;;
    fsd)
        MESSAGE='UPS has issue a forced shutdown command (FSD)'
        ;;
    shutdown)
        MESSAGE='UPS has shutdown the system'
        ;;
    replbatt)
        MESSAGE='UPS battery need to be replaced soon'
        ;;
    commbad)
        MESSAGE='Communication with ups went wrong'
        ;;
    ok)
        MESSAGE='UPS recovered normal state'
        SUBJECT='UPS Recovery'
        ;;
    *)
        logger -t upssched-cmd "Unrecognized command: $1"
        exit 0
        ;;
esac

# send mail to admin
echo "$MESSAGE" | mail -s "$SUBJECT" monitoring@alkivi.fr

# Add syslog
logger -t upssched-cmd $MESSAGE
