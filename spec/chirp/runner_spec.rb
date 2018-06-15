# frozen_string_literal: true

describe Chirp::Runner do
  subject { described_class.new(%w[whatever]) }

  it 'has a Child class' do
    expect(Chirp::Runner::Child).to_not be_nil
  end

  it 'accepts an action as first positional argument' do
    expect(subject.action).to eql 'whatever'
  end

  it 'runs perform_#{action}' do
    expect { subject.run! }.to raise_error NoMethodError
  end

  describe 'running scripts', integration: true do
    subject { described_class.new(%w[scripts]) }

    before do
      $stdout = StringIO.new
      $stderr = StringIO.new
    end

    after do
      $stdout = STDOUT
      $stderr = STDERR
    end

    %w[cpu disk memory network s3].each do |script_name|
      it "runs a #{script_name} script" do
        subject.run!
        expect($stdout.string).to match(
          %r{Spawning.*scripts\/#{script_name}"$}
        )
        expect($stdout.string).to match(
          /---> #{script_name} [\d\.]+ms \(exit 0\)$/
        )
      end
    end
  end
end
