> THIS IS NOT READY YET

# NanoACMEv2

This is a minimal shell based implementation of the ACME 2 protocol for LetsEncrypt.

- Runs in a secured environment, not on the insecure server itself
- `sftp` for HTTP-Challenge
- Future: DNS-Challenge
- Future: `git` for HTTP-/DNS-Challenge
- Future: shell based modules for special deployment needs
- Minimal in the sense it completely does the job and only speaks ACMEv2 (RFC 8555)
- Uses `git` for everything.  Automatic pulls require signed commits.
- Runs as any user
- Native support for distributed deployment like on loadbalancers
- Can run fully automatic in the background
- Easy configuration (just a `git` repository)
- Framework of many small scripts which are easy to understand and maintain

Note: "easy to understand and maintain" for me and only me, of(f) course.


## Usage

Install (alter `rundir` to suit your needs):

	git init rundir
	cd rundir
	git submodule add https://github.com/hilbix/nacme2.git
	nacme2/init.sh

Note: This adds a single hourly cron rule to run `bin/schedule.sh`
which does all the renewing and retry processing.

Domain:

	touch dom/example.com
	bin/check
	bin/run

Multi-Domain:

	echo example.org >> domains/example.com
	bin/check
	bin/run

Logs:

	ls -altr log/

Alternative to `bin/check && bin/run` if you like:

	make

Cron:

	nacme2/setup-cron


## `git`-structure

Legend:

- `push:` automated pushed on `git` server for backup
- `pull:` automated pull from `git` server for updates
- `both:` automated two-directional sync with automated conflict resolution
- `none:` `both:` if it is a `git submodule`, else ignored.  No need to backup these!

Structure (`rundir/` is the parent repository of this repository):

- `push: rundir/` push only main directory
- `pull: rundir/nacme2/` pull only, this repository here
- `both: rundir/dom/` two-way submodule, can be edited on server or locally
- `both: rundir/etc/` two-way submodule for all configuration (like ssh-config)
- `none: rundir/crt/` certificates.  **Sensitive information like private keys!**
- `none: rundir/log/` all logging output.  May contain sensitive information
- `none: rundir/tmp/` intermediate data.  No need to backup this, ever.


## FAQ

Logging to `stderr` instead of `rundir/log/`?

- `cd rundir && rm -rf log && touch log`

Run as service instead of `cron`?

- `echo 3600 > rundir/etc/schedule.txt`
- `rundir/bin/check`
- `exec rundir/bin/schedule`

Restore?

- `git clone --recursive ssh://git@git.example.com/your/rundir.git`
- `rundir/bin/check`

Question/Contact?

- Open issue on GitHub, eventually I listen

Bug/Contrib?

- Open PR on GitHub, eventually I listen

License?

- Free as free beer, free speech, free baby

