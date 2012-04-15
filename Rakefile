require 'rake'

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '-c --fail-fast'
  t.pattern = 'spec/*/*_spec.rb'
end
