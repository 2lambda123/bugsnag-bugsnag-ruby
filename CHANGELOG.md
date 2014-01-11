Changelog
=========

1.8.2
-----
-   Notify all exceptions in mailman and sidekiq

1.8.1
-----
-   Fix Rails2 middleware issue that stopped automatic metadata collection

1.8.0
-----
-   Move away from Jeweler
-   Support for Exception#cause in ruby 2.1.0

1.7.0
-----
-   Allow users to configure app type
-   Send severity of error to bugsnag
-   Allo users to configure users in a structured way for search etc.

1.6.5
-----
-   Send hostname to Bugsnag

1.6.4
-----
-   Fix load order issue with Resque

1.6.3
-----
-   Deal with SSL properly for deploy notifications on ruby <2.0

1.6.2
-----
-   Notify about exceptions that occur in ActiveRecord `commit` and `rollback`
    callbacks (these are usually swallowed silently by rails)

1.6.1
-----
-   Ensure sidekiq, mailman and rake hooks respect the `ignore_classes` setting
-   Persist sidekiq and mailman meta-data through each job, so it can show up
    in manual Bugsnag.notify calls

1.6.0
-----
-   Add support for catching crashes in [mailman](https://github.com/titanous/mailman) apps
-   Automatically enable Bugsnag's resque failure backend
-   Add automatic rake integration for rails apps

1.5.3
-----
-   Deal with self-referential meta data correctly.
-   Dont load the environment when performing a deploy with capistrano.

1.5.2
-----
-   Dont send rack.request.form_vars as it is a copy of form_hash and it may contain sensitive params.

1.5.1
-----
-   Fix rake block arguments for tasks that need them.

1.5.0
-----
-   Add proxy support for http requests to Bugsnag.
-   Read the API key from the environment for Heroku users

1.4.2
-----
-   Add HTTP Referer to the request tab on rack apps

1.4.0
-----
- 	Add ignore_user_agents to ignore certain user agents
-  	Change bugsnag middleware order to have Callbacks last
- 	Allow nil values to be sent to bugsnag

1.3.8
-----
- 	Add truncated only when a field has been truncated

1.3.7
-----
- 	Fix warden bug where user id is an array of ids
- 	Filter get params from URLs as well as meta_data

1.3.6
-----
-   Filter out meta-data keys containing the word 'secret' by default

1.3.5
-----
-   Fixed bug in rake integration with ruby 1.9 hash syntax

1.3.4
-----
-   Fix nil bug in windows backtraces

1.3.3
-----
-   Support windows-style paths in backtraces
-   Fix bug with `before_bugsnag_notify` in Rails 2

1.3.2
-----
-   Notify will now build exceptions if a non-exception is passed in.

1.3.1
-----
-   Add support for Bugsnag rake integration

1.3.0
------
-   By default we notify in all release stages now
-   Return the notification in notify_or_ignore

1.2.18
------
-   Add support for bugsnag meta data in exceptions.

1.2.17
------
-   Clear the before bugsnag notify callbacks on sidekiq when a job is complete

1.2.16
------
-   Allow lambda functions in config.ignore_classes

1.2.15
------
-   Add stacktrace to internal bugsnag logging output
-   Protect against metadata not being a hash when truncation takes place

1.2.14
------
-   Add debug method, configuration option to help debug issues
-   Better protection against bad unicode strings in metadata

1.2.13
------
-   Protect against invalid unicode strings in metadata

1.2.12
------
-   Fixed minor HTTParty dependency issue

1.2.11
------
-   Send rails version with exceptions
-   Protect against nil params object when errors happen in rack

1.2.10
------
-   Added Rack HTTP method (GET, POST, etc) to request tab

1.2.9
-----
-   Fixed an issue with Warden userIds not being reported properly.

1.2.8
-----
-   Added `disable` method to Bugsnag middleware, allows you to force-disable
    built-in Bugsnag middleware.

1.2.7
-----
-   Protect against rare exception-unwrapping infinite loop 
    (only in some exceptions using the `original_exception` pattern)

1.2.6
-----
-   Fix for rails 2 request data extraction
-   Deploy environment customization support (thanks coop)
-   Ensure Bugsnag rails 3 middleware runs before initializers

1.2.5
-----
-   Show a warning if no release_stage is set when delivering exceptions
-   Require resque plugin in a safer way

1.2.4
-----
-   Automatically set the release_stage in a safer way on rack/rails

1.2.3
-----
-   Re-add support for sending bugsnag notifications via resque

1.2.2
-----
-   Add rspec tests for rack middleware

1.2.1
-----
-   Fix a bug where before/after hooks were not being fired

1.2.0
-----
-   Added Bugsnag Middleware and callback, easier ways to add custom data to
    your exceptions
-   Added automatic Sidekiq integration
-   Added automatic Devise integration
-   Comprehensive rspec tests

1.1.5
-----
-   Fix minor internal version number parsing bug

1.1.4
-----
-   Move Bugsnag rack middleware later in the middleware stack, fixes 
    issue where development exception may not have been delivered

1.1.3
-----
-   Fix multi_json conflict with rails 3.1
-   Make bugsnag_request_data public for easier EventMachine integration
    (thanks fblee)

1.1.2
-----
-   Fix multi_json gem dependency conflicts

1.1.1
-----
-   Capistrano deploy tracking support
-   More reliable project_root detection for non-rails rack apps
-   Support for sending test exceptions from rake (`rake bugsnag:test_exception`)

1.1.0
-----
-   First public release
