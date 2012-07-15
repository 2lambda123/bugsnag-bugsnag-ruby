require "rubygems"

require "bugsnag/version"
require "bugsnag/configuration"
require "bugsnag/notification"
require "bugsnag/helpers"

require "bugsnag/rack"
require "bugsnag/railtie" if defined?(Rails::Railtie)

require "resque/failure/bugsnag" if defined?(Resque)

module Bugsnag
  LOG_PREFIX = "** [Bugsnag] "

  class << self
    # Configure the gem to send notifications, at the very least an api_key is required
    def configure
      yield(configuration)

      # Use resque for asynchronous notification if required
      require "bugsnag/delay/resque" if configuration.delay_with_resque && defined?(Resque)

      # Log that we are ready to rock
      if configuration.api_key && !@logged_ready
        log "Bugsnag exception handler #{VERSION} ready, api_key=#{configuration.api_key}" 
        @logged_ready = true
      end
    end

    # Explicitly notify of an exception
    def notify(exception, session_data={})
      Notification.new(exception, configuration.merge(session_data)).deliver
    end

    # Notify of an exception unless it should be ignored
    def notify_or_ignore(exception, session_data={})
      notification = Notification.new(exception, configuration.merge(session_data))
      notification.deliver unless notification.ignore?
    end

    # Auto notify of an exception, called from rails and rack exception 
    # rescuers, unless auto notification is disabled, or we should ignore this
    # error class
    def auto_notify(exception, session_data={})
      notify_or_ignore(exception, session_data) if configuration.auto_notify
    end

    # Log wrapper
    def log(message)
      configuration.logger.info(LOG_PREFIX + message) if configuration.logger
    end

    # Warning logger
    def warn(message)
      if configuration.logger
        configuration.logger.warn(LOG_PREFIX + message)
      else
        puts "#{LOG_PREFIX}#{message}"
      end
    end

    # Configuration getter
    def configuration
      @configuration ||= Bugsnag::Configuration.new
    end
  end
end