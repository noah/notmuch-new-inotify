#!/bin/sh 

# notmuch-new-inotify.sh
#   update the notmuch database when mail is delivered, well more
#   precisely when a close_write event is detected.  This is one way of
#   using Postfix and notmuch together without resorting to procmail.

MAILDIR_ROOT=/home/noah/mail
MIN_INDEX_AGE=1


oldtime=0
inotifywait --monitor \
            --recursive \
            --event close_write \
            --timefmt '%s' --format '%T %w %f' \
            $MAILDIR_ROOT | \

            while read newtime dir file; do

                # the index age is greater than the minimum index age
                if [ $((newtime-oldtime)) -ge $MIN_INDEX_AGE ]; then
                    # incorporate new mail into the notmuch database
                    /usr/bin/notmuch new 2>&1
                fi
                oldtime=$newtime

            done
