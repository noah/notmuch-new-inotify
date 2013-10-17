# About

This script runs continuously and calls `notmuch new` whenever it
detects an `IN_CLOSE_WRITE` event in your `$MAILDIR_ROOT` (see man 7
inotify for the list of events).  Presumably `CLOSE_WRITE` will
correspond to things like new mail being delivered, a draft being
saved, etc.

# Dependencies

The superb [https://github.com/rvoicilas/inotify-tools/](inotify-toools)

    % sudo pacman -S inotify-tools

# Assumptions

This will need to run as the correct user (the one with the
`~/.notmuch-config` file).  Setting `User=<user>` in the service file
should be sufficient to accomplish this.

Also, the service file assumes the repository was cloned to `~/src`.

# Installation

Pending a proper OS package, this works:

    % sudo ln -s ~/src/notmuch-new-inotify/notmuch-new-inotify.service /lib/systemd/
    % sudo systemctl daemon-reload
    % sudo systemctl enable notmuch-new-inotify.service
    % sudo systemctl start notmuch-new-inotify.service

# Motivation

Procmail slows Postfix down.  Postfix content filtering is also
reputedly slow.  So premature optimization.

And I wanted to learn how to write Systemd scripts

# License

GPLv2 (please share back)

# TODO

* Create an install script
* setup User systemd profile (currently a *mess* https://wiki.archlinux.org/index.php/Systemd/User)


