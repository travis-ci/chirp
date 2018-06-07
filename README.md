TEstanjaets

# chirp

Chirp is meant to be set up with Travis CI to repeatedly build itself for
purposes of real world monitoring.

## setup

1. Add this gem as a dependency in a `Gemfile`, e.g.
   `gem 'chirp', github: 'travis-ci/chirp'`
1. Add a `.travis.yml` with required bits
    * Ensure it is `language: ruby` or at least uses a language with `bundler`
      available
    * Ensure the `script` step includes `bundle exec chirp scripts`
    * Optionally, add an `after_success` step that includes:
        * `bundle exec chirp pushback &>/dev/null`
        * `bundle exec chirp sendstats &>/dev/null`
    * Optionally, add an `after_failure` step with `bundle exec chirp dumplogs`
1. `travis enable`
1. Generate a github token with `repo` scope
1. `travis env set GITHUB_OAUTH_TOKEN <github-token>`
