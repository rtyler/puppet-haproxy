
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
  end
end
