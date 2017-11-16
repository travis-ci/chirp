# frozen_string_literal: true

module Chirp
  class Runner
    Child = Struct.new(
      :script, :exit_status, :pid, :started_time, :completed_time
    ) do
      def basename
        @basename ||= File.basename(script)
      end
    end
  end
end
