# frozen_string_literal: true

require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['--display-cop-names', '-a']
end

RSpec::Core::RakeTask.new(:spec)

task default: %i[rubocop spec]
