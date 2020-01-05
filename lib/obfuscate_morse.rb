# frozen_string_literal: true

require 'pry-byebug'
# translate the alphanumeric sentence to Morse code and then obfuscate
# see README and tests in `spec/` folder for more details

def obfuscated_morse(string_or_filename)
  raise InvalidArgumentError, MESSAGE unless string_or_filename.is_a?(String)

  obfuscate(morse(check_for_file_content(string_or_filename)))
end

def check_for_file_content(string_or_filename)
  File.readlines(string_or_filename)
rescue StandardError => _e
  puts "No filename #{string_or_filename}, so processing as string"
  string_or_filename
end

MESSAGE = 'argument must be filename or string'

def morse(string)
  string.split("\n").map do |line|
    line.split(' ').map do |word|
      word.chars.map do |char|
        "#{MORSE[char]}|"
      end.join.chomp('|')
    end.join('/')
  end.join("\n")
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
