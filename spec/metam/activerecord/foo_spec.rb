# encoding: utf-8

require 'spec_helper'
require 'support/activerecord/foo'

describe Metam::Activerecord::Model do

  before(:each) do
    @foo = Support::Activerecord::Foo.new
  end

  it 'does not raise any error' do
    expect do
      @foo.valid?

    end.not_to raise_error
  end

end
