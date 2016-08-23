module Bugsnag::Rails
  module ActiveRecordRescue
    KINDS = [:commit, :rollback].freeze

    def run_callbacks(kind, *args, &block)
      if KINDS.include?(kind)
        begin
          super
        rescue StandardError => exception
          # This exception will NOT be escalated, so notify it here.
          Bugsnag.notify(exception, true) do |report|
            report.severity = "error"
          end
          raise
        end
      else
        # Let the post process handle the exception
        super
      end
    end
  end
end
