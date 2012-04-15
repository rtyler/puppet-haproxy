require 'rspec-puppet'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
end

def no_concat_for(name, title)
  let(:params) do
    { name => false }
  end
  it { should_not contain_concat__fragment(title) }
end

def config_line(value)
  "\t#{value}\n"
end
