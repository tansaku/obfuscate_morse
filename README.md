Obfuscated Morse
================

A program that will accept text either from stdin, or as a file path and will translate the alphanumeric sentence to Morse code and then obfuscate the Morse code. Below is a list of international Morse code and the algorithm for obfuscation. Letters are separated with pipe (|), and words are separated with forward slash (/).

The current implementation uses a lookup table of characters to morse code, looping through lines, words and chars and replacing chars one by one and re-joining them with the appropriate "separator" characters (pipe or slash).  Obfuscation takes place by replacing strings matching sets of dots and dashes of particular lengths with the appropriate characters. 

File input, STDIN input and file output support are also provided

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

### Example

  *  Sentence: I AM IN TROUBLE
  *  Morse Code: ../.-|--/..|-./-|.-.|---|..-|-...|.-..|.
  *  Obfuscated Morse Code: 2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1

#### Input

An example input text file:

```
HELLO
I AM IN TROUBLE
```

#### Output

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

In an irb REPL:

```irb
$ bundle exec irb
2.6.5 :001 > require './lib/obfuscate_morse'
 => false 
2.6.5 :002 > obfuscated_morse('HELLO THERE')
W, [2020-01-06T08:32:18.564286 #33058]  WARN -- : No file HELLO THERE, so processing as string: No such file or directory @ rb_sysopen - HELLO THERE
 => "4|1|1A2|1A2|C/A|4|1|1A1|1" 
2.6.5 :003 > morse('HELLO THERE')
 => "....|.|.-..|.-..|---/-|....|.|.-.|." 
```

To read from a file simply pass a valid filename instead of a string, and the contents of the file will be converted.  If an output file is desired pass a second argument with the file name, and the result will be written to that file:

```irb
$ bundle exec irb
2.6.5 :001 > require './lib/obfuscate_morse'
 => false 
2.6.5 :002 > obfuscated_morse('tmp/input.txt', 'tmp/output.txt')
 => "4|1|1A2|1A2|C" 
 ```

 Input can also be taken from STDIN like so:

```irb
$ bundle exec irb
2.6.5 :001 > require './lib/obfuscate_morse'
 => false 
2.6.5 :002 > obfuscated_morse('stdin')
HELLO THERE!
 => "4|1|1A2|1A2|C/A|4|1|1A1|1|" 
```

Note that when reading from STDIN, Ctrl-D or similar is required to terminate the input and proceed with morsing and obfuscating.


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
Inspecting 6 files
.....

6 files inspected, no offenses detected
...

obfuscate_morse
  obfuscates morse for "I AM IN TROUBLE"
  obfuscates morse "HELLO"
  ignores invalid chars
  obfuscates all possible chars
  morses "HELLO"
  morses "I AM IN TROUBLE"
  morses all possible chars
  handles file input
  handles STDIN input
  can output to file
  errors if not receiving string or filename as argument

Finished in 0.01223 seconds (files took 0.78073 seconds to load)
10 examples, 0 failures


COVERAGE: 100.00% -- 27/27 lines in 1 files
```

Performance
-----------
Obfuscation gives a clear drop in performance.  Run performance check via:

```sh
$ rake performance
```

Which will give output like the following:

```
yarn run v1.15.2
$ rake performance
              user     system      total        real
morse:    0.122377   0.007558   0.129935 (  0.138081)
obfuscated:  0.606511   0.019096   0.625607 (  0.646695)
```

Issues
------
* Currently just ignores invalid chars, using `gsub('||', '|')` to remove any impact of their presence - should we perhaps be raising errors?
* Currently raises an error for any non-string input, but perhaps could automatically stringify incoming input via `String(non_string)`?
* Have broken larger morse method into multiple one line methods.  Is this easier to understand than the original?
* Currently using LOGGER as constant - should we swtich to a class and use dependency injection?
  - note `lib/obfuscate_morse.rb` getting close to comfortable length for single file - time to split?
* Switching to STDIN based on sending 'stdin' string - brittle? Incompatible with upcasing?
* Currently stubbing STDIN and File which is mocking something we don't own - another argument for the addition of dependency injection support.
* Are code methods at right level of abstraction - is the narrative easily followed?  Probably not as much as it could be ... should improve as part of move to class/object structure


Future Work
-----------
* Automatically upper case incoming string?
* Improve performance
* Release as RubyGem?

