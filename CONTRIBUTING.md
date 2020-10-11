
## How to contribute

We are glad you're here! First-time and returning contributors are welcome to
add bug fixes and new integrations. If you are unsure about the direction of an
enhancement or if it would be generally useful, feel free to open an issue or a
work-in-progress pull request and ask for input.

Thank you!

### Getting started

* [Fork](https://help.github.com/articles/fork-a-repo) the [library on github](https://github.com/bugsnag/bugsnag-ruby)
* Commit and push until you are happy with your contribution

### Polish

* Run the tests with and make sure they all pass
    ```
    bundle exec rake spec
    ```
    
    _NOTE: You may need to install the bundle with the `test` group first by running `bundle install --with test`. Otherwise, you will get `can't find executable rake for gem rake` error._
    
* Further information on installing and running the tests can be found in [the testing guide](TESTING.md)

### Document

* Write API docs for your contributions using [YARD](https://yardoc.org/)
* Generate the API documentation locally
    ```
    bundle exec rake yard
    ```
* Review your changes by opening `doc/index.html`

### Ship it!

* [Make a pull request](https://help.github.com/articles/using-pull-requests)

## How to release

If you're a member of the core team, follow these instructions for releasing bugsnag-ruby.

### First time setup

* Create a Rubygems account
* Get James/Simon to add you as contributor on bugsnag-ruby in Rubygems

### Every time

* Update `VERSION`
* Update `CHANGELOG.md`
* Update `README.md` if necessary
* Commit/push your changes

    ```
    git add VERSION CHANGELOG.md README.md
    git commit -m "Release v6.x.x"
    git push origin master
    ```

* Release to rubygems

    ```
    gem build bugsnag.gemspec
    gem push bugsnag-[version].gem
    ```

* Update the version running in the bugsnag-website project

### Update docs.bugsnag.com

Update the setup guides for Ruby (and its frameworks) with any new content.
