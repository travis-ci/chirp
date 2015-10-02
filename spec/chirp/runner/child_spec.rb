describe Chirp::Runner::Child do
  %i(script exit_status pid started_time completed_time).each do |method_name|
    it "responds to #{method_name}" do
      expect(subject).to respond_to(method_name)
    end
  end
end
