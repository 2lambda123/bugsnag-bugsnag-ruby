require 'shoryuken'

module Bugsnag
  class Shoryuken

    FRAMEWORK_ATTRIBUTES = {
      :framework => "Shoryuken"
    }

    ##
    # Extracts and attaches additional shoryuken application data to the report.
    def initialize
      Bugsnag.configure do |config|
        config.app_type ||= "shoryuken"
        config.default_delivery_method = :synchronous
      end
    end

    ##
    # Exectures the middleware.
    def call(_, queue, _, body)
      begin
        Bugsnag.before_notify_callbacks << lambda {|report|
          report.add_tab(:shoryuken, {
            queue: queue,
            body: body
          })
        }

        yield
      rescue Exception => ex
        unless [Interrupt, SystemExit, SignalException].include?(ex.class)
          Bugsnag.notify(ex, true) do |report|
            report.severity = "error"
            report.severity_reason = {
              :type => Bugsnag::Report::UNHANDLED_EXCEPTION_MIDDLEWARE,
              :attributes => Bugsnag::Shoryuken::FRAMEWORK_ATTRIBUTES
            }
          end
        end
        raise
      ensure
        Bugsnag.configuration.clear_request_data
      end
    end
  end
end

::Shoryuken.configure_server do |config|
  config.server_middleware do |chain|
    chain.add ::Bugsnag::Shoryuken
  end
end
