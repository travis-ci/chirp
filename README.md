# chirp

This repository is meant to be set up with Travis CI to repeatedly build itself for purposes of real world
monitoring.  There is a server component called [chirp-tracker](https://github.com/travis-infrastructure/chirp-tracker)
that understands both github and travis webhook payloads and keeps a record of timestamps and commits from each such
that a delta may be used as a simple metric for high level alerts.
