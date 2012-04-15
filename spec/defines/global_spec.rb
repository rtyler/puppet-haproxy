require 'spec_helper'

describe 'haproxy::global' do
  let(:title) { 'unused' }

  it { should include_class('concat::setup') }

  context 'with arguments' do
  end
end
