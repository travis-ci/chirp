describe Chirp::Runner do
  subject { described_class.new(%w(whatever)) }

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
    subject { described_class.new(%w(scripts)) }

    before do
      $stdout = StringIO.new
      $stderr = StringIO.new
    end

    after do
      $stdout = STDOUT
      $stderr = STDERR
    end

    it 'does not explode' do
      expect { subject.run! }.to_not raise_error StandardError
    end
  end
end
