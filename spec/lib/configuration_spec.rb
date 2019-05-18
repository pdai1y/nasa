require 'spec_helper'

RSpec.describe NASA::Configuration do
  before do
    configure
  end

  let(:api_key) { NASA.api_key }
  let(:debug) { NASA.debug }

  it 'has an API Key' do
    expect(api_key).not_to eq(nil)
  end

  it 'set debug to true' do
    expect(debug).to eq(true)
  end
end
