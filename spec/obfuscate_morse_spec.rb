# frozen_string_literal: true

require 'obfuscate_morse'
require 'pry-byebug'

describe 'obfuscate_morse' do
  let(:multiline_file_contents) do
    'HELLO
     I AM IN TROUBLE'
  end
  before do  
    # be good to stub logger ...
  end
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
  it 'handles files' do
    result = "4|1|1A2|1A2|C\n"
    result += '2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1'
    expect(File).to receive(:readlines).and_return(multiline_file_contents)
    expect(obfuscated_morse('filename')).to eq result
  end
  it 'errors if not receiving string or filename as argument' do
    expect { obfuscated_morse([]) }.to raise_error InvalidArgumentError
  end
end
