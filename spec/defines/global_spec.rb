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
          'content' => config_line('debug')
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
          'content' => config_line('quiet')
        )
      }
    end
    context 'chroot => <some directory>' do
      let(:chroot) { '/var/test-dir' }
      let(:params) do
        { :chroot => '/var/test-dir' }
      end

      it {
        should contain_concat__fragment("chroot to #{chroot}").with(
          'target'  => config_file,
          'order'   => 2,
          'content' => config_line("chroot #{chroot}")
        )
      }

      it {
        should contain_file(chroot).with(
          'ensure' => 'directory',
          'mode'   => 755
        )
      }
    end
    context 'daemonize => false' do
      no_concat_for(:daemonize, 'daemonize')
    end
    context 'daemonize => true' do
      let(:params) do
        { :daemonize => true }
      end

      it {
        should contain_concat__fragment('daemonize').with(
          'target'  => config_file,
          'order'   => 2,
          'content' => config_line('daemon')
        )
      }
    end
    context 'gid => <some number>' do
      let(:gid) { 1337 }
      let(:params) do
        { :gid => gid }
      end

      it {
        should contain_concat__fragment("gid #{gid}").with(
          'target'  => config_file,
          'order'   => 2,
          'content' => config_line("gid #{gid}")
        )
      }
      it {
        should contain_group(gid).with(
          'ensure' => 'present',
          'gid'    => gid
        )
      }
    end
    context 'group => <some group name>' do
      let(:group) { 'rspec' }
      let (:params) do
        { :group => group }
      end
      it {
        should contain_concat__fragment("group #{group}").with(
          'target'  => config_file,
          'order'   => 2,
          'content' => config_line("group #{group}")
        )
      }
      it {
        should contain_group(group).with(
          'ensure' => 'present',
          'name'   => group
        )
      }
    end
  end
end
