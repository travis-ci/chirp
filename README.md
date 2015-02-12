# chirp

This repository is meant to be set up with Travis CI to repeatedly build itself for purposes of real world
monitoring.  There is a server component called [chirp-tracker](https://github.com/travis-infrastructure/chirp-tracker)
that understands both github and travis webhook payloads and keeps a record of timestamps and commits from each such
that a delta may be used as a simple metric for high level alerts.

## setup

0. `travis enable`
0. Generate a github token with `repo`
0. `travis env set GITHUB_OAUTH_TOKEN <github-token>`
0. Add a webhook on github for chirp-tracker, e.g. `https://chirp-tracker-production.herokuapp.com/github` with content
   type of `application/x-www-form-urlencoded` and the secret token configured on the server side.  Only the `push`
event needs to be configured.
