# vim:fileencoding=utf-8
# frozen_string_literal: true
describe Chirp do
  it 'has a Runner' do
    expect(Chirp::Runner).to_not be_nil
  end

  it 'has a VERSION' do
    expect(Chirp::VERSION).to_not be_nil
  end
end
