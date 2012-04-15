
describe 'haproxy' do
  let (:title) { 'unused?' }

  it { should include_class('concat::setup') }

  # NOTE: this is likely unnecessary precision, I doubt CentOS names their
  # haproxy package anything other than haproxy
  context 'on debian systems' do
    let(:facts) do
      { :operatingsystem => 'Ubuntu' }
    end

    it 'should install the haproxy package' do
      subject.should contain_package('haproxy').with(
        'ensure' => 'present'
      )
    end

    it 'should install the haproxy service' do
      subject.should contain_service('haproxy').with(
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasrestart' => 'true',
        'hasstatus'  => 'true'
      )
    end

    it 'should install a new /etc/default/haproxy' do
      subject.should contain_file('/etc/default/haproxy').with(
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => 'root',
        'source' => 'puppet:///modules/haproxy/haproxy.default.etc'
      )
    end

    it 'should set up /etc/haproxy/haproxy.cfg as a concat resource' do
      subject.should contain_concat('/etc/haproxy/haproxy.cfg').with(
        'owner' => 'root',
        'group' => 'root',
        'mode'  => 644
      )
    end
  end
end
