# encoding: utf-8

require 'spec_helper'

describe Metam::Klass do

  before(:each) do
    @scope = Metam::Scope.new('affiliation1')
  end

  describe 'User klass' do
    before(:each) do
      @klass = @scope.klass('User')
    end

    describe '#attribute_names' do
      it 'returns :name, :familyname :birthdate :time :email :zip_code :ratio :telephone :website :distribution_share :content' do
        expect(@klass.attribute_names).to eq(%w(name familyname birthdate time email zip_code ratio telephone website distribution_share content))
      end
    end

    describe '#attribute' do
      it 'returns an attribute instance' do
        expect(@klass.attribute('name')).to be_a(Metam::Attribute)
      end
    end
  end

end
