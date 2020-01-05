# frozen_string_literal: true

require 'obfuscate_morse'

describe 'obfuscate_morse' do
  it 'obfuscates morse for "I AM IN TROUBLE"' do
    result = '2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1'
    expect(obfuscated_morse('I AM IN TROUBLE')).to eq result
  end
  it 'obfuscates morse "HELLO"' do
    result = '4|1|1A2|1A2|C'
    expect(obfuscated_morse('HELLO')).to eq result
  end
  it 'morses "HELLO"' do
    result = '....|.|.-..|.-..|---'
    expect(morse('HELLO')).to eq result
  end
  it 'morses "I AM IN TROUBLE"' do
    result = '../.-|--/..|-./-|.-.|---|..-|-...|.-..|.'
    expect(morse('I AM IN TROUBLE')).to eq result
  end
end
