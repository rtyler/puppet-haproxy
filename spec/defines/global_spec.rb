require 'spec_helper'

describe 'haproxy::global' do
  let(:title) { 'unused' }
  let(:config_file) { '/etc/haproxy/haproxy.cfg' }
  # XXX: Commented out because LOLBUGS:
  # <https://github.com/rodjek/rspec-puppet/issues/26>
  #let(:pre_condition) do
  #  # NOTE: According to @rodjek this is an undocumented hack and may be
  #  # deprecated in the future for a nicer approach
  #  '$haproxy::config_file = "/etc/haproxy/haproxy.cfg"'
  #end

  it { should include_class('concat::setup') }

  it 'should create the "global" section at the top of the config file' do
    subject.should contain_concat__fragment('haproxy global block').with(
      'target'  => config_file,
      'order'   => 1,
      'content' => "global\n"
    )
  end

  context 'with options' do
    context 'debug_mode => false' do
      let(:params) do
        { :debug_mode => false }
      end

      it {
        subject.should_not contain_concat__fragment('enable debugging')
      }
    end
    context 'debug_mode => true' do
      let(:params) do
        { :debug_mode => true }
      end

      it {
        subject.should contain_concat__fragment('enable debugging').with(
          'target'  => config_file,
          'order'   => 2,
          'content' => "\tdebug\n"
        )
      }
    end
  end
end
