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
    should contain_concat__fragment('haproxy global block').with(
      'target'  => config_file,
      'order'   => 1,
      'content' => "global\n"
    )
  end

  context 'with options' do
    context 'debug_mode => false' do
      no_concat_for(:debug_mode, 'enable debugging')
    end
    context 'debug_mode => true' do
      let(:params) do
        { :debug_mode => true }
      end

      it {
        should contain_concat__fragment('enable debugging').with(
          'target'  => config_file,
          'order'   => 2,
          'content' => "\tdebug\n"
        )
      }
    end

    context 'quiet_mode => false' do
      no_concat_for(:quiet_mode, 'enable quiet mode')
    end

    context 'quiet_mode => true' do
      let(:params) do
        { :quiet_mode => true }
      end

      it {
        should contain_concat__fragment('enable quiet mode').with(
          'target'  => config_file,
          'order'   => 2,
          'content' => "\tquiet\n"
        )
      }
    end
  end
end
