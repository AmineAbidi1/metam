# encoding: utf-8

require 'spec_helper'

describe Metam::Attribute do

  before(:each) do
    @scope = Metam::Scope.new('affiliation1')
    @klass = @scope.klass('User')
  end

  describe '#validations' do
    it 'returns the validations' do
      attribute = @klass.attribute('name')

      hsh = {
        'presence' => 'true',
        'datatype' => 'string',
        'maxlength' => '10',
        'minlength' => '2'

      }

      expect(attribute.validations).to eq(hsh)
    end
  end

  describe '#name' do
    it "returns 'familyname'" do
      attribute = @klass.attribute('familyname')
      expect(attribute.name).to eq('familyname')
    end
  end
end
