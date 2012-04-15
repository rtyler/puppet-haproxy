require 'spec_helper'

describe 'haproxy::global', :type => :define do
  let(:title) { 'this has to be here because rspec-puppet is dumbz' }

  it {
    should include_class('concat::setup')
  }
end
