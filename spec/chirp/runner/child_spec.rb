# vim:fileencoding=utf-8
# frozen_string_literal: true
describe Chirp::Runner::Child do
  %w(script exit_status pid started_time completed_time).each do |method_name|
    it "responds to #{method_name}" do
      expect(subject).to respond_to(method_name)
    end
  end
end
