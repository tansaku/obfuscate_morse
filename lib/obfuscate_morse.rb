# frozen_string_literal: true

require 'logger'

LOGGER = Logger.new(STDOUT)
LOGGER.level = Logger::WARN

# translates alphanumeric (upper case) sentences to Morse code and then
# obfuscates - see README and tests in `spec/` folder for more details

def obfuscated_morse(string_or_filename, output_file = nil)
  raise InvalidArgumentError, MESSAGE unless string_or_filename.is_a?(String)

  result = obfuscate(morse(check_for_content_source(string_or_filename)))
  file_output(output_file, result) if output_file
  result
end

def morse(string)
  string.split("\n").map { |line| morse_line(line) }.join("\n").gsub('||', '|')
end

def obfuscate(string)
  string.gsub(Regexp.union(OBFUSCATION.keys), OBFUSCATION)
end

OBFUSCATION = {
  '.....' => '5',
  '....' => '4',
  '...' => '3',
  '..' => '2',
  '.' => '1',
  '-----' => 'E',
  '----' => 'D',
  '---' => 'C',
  '--' => 'B',
  '-' => 'A'
}.freeze

MORSE = {
  'A' => '.-',
  'B' => '-...',
  'C' => '-.-.',
  'D' => '-..',
  'E' => '.',
  'F' => '..-.',
  'G' => '--.',
  'H' => '....',
  'I' => '..',
  'J' => '.---',
  'K' => '-.-',
  'L' => '.-..',
  'M' => '--',
  'N' => '-.',
  'O' => '---',
  'P' => '.--.',
  'Q' => '--.-',
  'R' => '.-.',
  'S' => '...',
  'T' => '-',
  'U' => '..-',
  'V' => '...-',
  'W' => '.--',
  'X' => '-..-',
  'Y' => '-.--',
  'Z' => '--..',
  '0' => '-----',
  '1' => '.----',
  '2' => '..---',
  '3' => '...--',
  '4' => '....-',
  '5' => '.....',
  '6' => '-....',
  '7' => '--...',
  '8' => '---..',
  '9' => '----.',
  '.' => '.-.-.-',
  ',' => '--..--',
  "\n" => "\n"
}.freeze

class InvalidArgumentError < StandardError; end

private

def morse_line(line)
  line.split(' ').map { |word| morse_word(word) }.join('/')
end

def morse_word(word)
  word.chars.map { |char| morse_char(char) }.join('|')
end

def morse_char(char)
  MORSE[char]
end

def check_for_content_source(string_or_filename_or_stdin)
  return STDIN.read if string_or_filename_or_stdin == 'stdin'

  File.read(string_or_filename_or_stdin)
rescue StandardError => e
  log = "No input file named '#{string_or_filename_or_stdin}'',"
  log += "so processing as string (original error: '#{e}')'"
  LOGGER.warn log
  string_or_filename_or_stdin
end

def file_output(file, result)
  File.write(file, result)
rescue StandardError => e
  log = "No output file named '#{file}'',"
  log += " so cannot write to it (original error: '#{e}')'"
  LOGGER.warn log
end

MESSAGE = 'argument must be filename or string'
