require 'spec_helper'

describe 'haproxy::defaults' do
  let(:title) { 'unused' }

  it {
    should include_class('concat::setup')
  }
end
