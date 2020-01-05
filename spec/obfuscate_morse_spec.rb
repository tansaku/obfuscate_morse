# frozen_string_literal: true

require 'obfuscate_morse'
require 'pry-byebug'

describe 'obfuscate_morse' do
  let(:multiline_file_contents) do
    'HELLO
     I AM IN TROUBLE'
  end
  before do
    LOGGER.level = Logger::ERROR
  end
  it 'obfuscates morse for "I AM IN TROUBLE"' do
    result = '2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1'
    expect(obfuscated_morse('I AM IN TROUBLE')).to eq result
  end
  it 'obfuscates morse "HELLO"' do
    result = '4|1|1A2|1A2|C'
    expect(obfuscated_morse('HELLO')).to eq result
  end
  it 'ignores invalid chars' do
    result = '4|1|1A2|1A2|C'
    expect(obfuscated_morse('HeE>L(L}O')).to eq result
  end
  it 'obfuscates all possible chars' do
    string = MORSE.keys.join
    result = '1A|A3|A1A1|A2|1|2A1|B1|4|2|1C|A1A|1A2|B|A1|C|1B1|B1A|1A1|3|A|2A|'
    result += '3A|1B|A2A|A1B|B2|E|1D|2C|3B|4A|5|A4|B3|C2|D1|1A1A1A|B2B'
    expect(obfuscated_morse(string)).to eq result
  end
  it 'morses "HELLO"' do
    result = '....|.|.-..|.-..|---'
    expect(morse('HELLO')).to eq result
  end
  it 'morses "I AM IN TROUBLE"' do
    result = '../.-|--/..|-./-|.-.|---|..-|-...|.-..|.'
    expect(morse('I AM IN TROUBLE')).to eq result
  end
  it 'morses all possible chars' do
    string = MORSE.keys.join
    result = MORSE.values.join('|').chomp("\n").chomp('|').to_s
    expect(morse(string)).to eq result
  end
  it 'handles file input' do
    result = "4|1|1A2|1A2|C\n"
    result += '2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1'
    expect(File).to receive(:read).and_return(multiline_file_contents)
    expect(obfuscated_morse('filename')).to eq result
  end
  it 'handles STDIN input' do
    result = '4|1|1A2|1A2|C'
    expect(STDIN).to receive(:read).and_return('HELLO')
    expect(obfuscated_morse('stdin')).to eq result
  end
  it 'can output to file' do
    result = '4|1|1A2|1A2|C'
    output_file = 'tmp/output.txt'
    expect(File).to receive(:write).with(output_file, result)
    expect(obfuscated_morse('HELLO', output_file)).to eq result
  end
  it 'can handle error when output file does not exist' do
    result = '4|1|1A2|1A2|C'
    output_file = 'tmp/output.txt'
    expect(File).to receive(:write).and_raise StandardError, 'no file'
    expect(obfuscated_morse('HELLO', output_file)).to eq result
  end
  it 'errors if not receiving string or filename as argument' do
    expect { obfuscated_morse([]) }.to raise_error InvalidArgumentError
  end
end
