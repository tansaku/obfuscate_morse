Obfuscated Morse
================

A program that will accept text either from stdin, or as a file path and will translate the alphanumeric sentence to Morse code and then obfuscate the Morse code. Below is a list of international Morse code and the algorithm for obfuscation. Letters are separated with pipe (|), and words are separated with forward slash (/).

International Morse Code
------------------------

  *  A .-
  *  B -...
  *  C -.-.
  *  D -..
  *  E .
  *  F ..-.
  *  G --.
  *  H ....
  *  I ..
  *  J .---
  *  K -.-
  *  L .-..
  *  M --
  *  N -.
  *  O ---
  *  P .--.
  *  Q --.-
  *  R .-.
  *  S ...
  *  T -
  *  U ..-
  *  V ...-
  *  W .--
  *  X -..-
  *  Y -.--
  *  Z --..
  *  0 -----
  *  1 .----
  *  2 ..---
  *  3 ...--
  *  4 ....-
  *  5 .....
  *  6 -....
  *  7 --...
  *  8 ---..
  *  9 ----.
  *  Fullstop .-.-.-
  *  Comma --..--

Obfuscation
------------

The obfuscation algortihm replaces the number of consecutive dots with a number, and replaces the number of consecutive dashes with the letter of the alphabet at that position. E.g. 

> S = ... = 3, Q = --.- = b1a, F = ..-. = 2a1.

###Example

  *  Sentence: I AM IN TROUBLE
  *  Morse Code: ../.-|--/..|-./-|.-.|---|..-|-...|.-..|.
  *  Obfuscated Morse Code: 2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1

####Input

An example input text file:

```
HELLO
I AM IN TROUBLE
```

####Output

A text file in the following format:

```
4|1|1A2|1A2|C
2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1
```

Requirements
------------
Ruby 2.6 and above.
Tested and run using Ruby version 2.6.5.

Installation
------------
Run the following in the root of the project to install dependencies

```sh
$ bundle 
```

Usage
-----

In a irb REPL:

```irb
$ bundle exec irb
2.6.5 :001 > require './lib/obfuscate_morse'
 => false 
2.6.5 :002 > obfuscated_morse('HELLO THERE')
 => "4|1|1A2|1A2|C/A|4|1|1A1|1" 
2.6.5 :003 > morse('HELLO THERE')
 => "....|.|.-..|.-..|---/-|....|.|.-.|." 
```

Reading from a file:



Testing
-------

The code can be tested as follows

```sh
$ bundle exec rspec
```

Should give output like the following (including test coverage):

```sh
$ be rake
Running RuboCop...
Inspecting 5 files
.....

5 files inspected, no offenses detected
...

obfuscate_morse
  obfuscates morse for "I AM IN TROUBLE"
  obfuscates morse "HELLO"
  morses "HELLO"
  morses "I AM IN TROUBLE"

Finished in 0.00199 seconds (files took 0.18806 seconds to load)
4 examples, 0 failures


COVERAGE: 100.00% -- 8/8 lines in 1 files
```

Todo
-----
* more test cases
* comments?
* error handling
* performance
* github
