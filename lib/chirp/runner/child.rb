# frozen_string_literal: true

module Chirp
  class Runner
    Child = Struct.new(
      :script, :exit_status, :pid, :started_time, :completed_time
    ) do
      def basename
        @basename ||= File.basename(script)
      end

      def duration_ms
        (completed_time - started_time) * 1000.0
      end
    end
  end
end
