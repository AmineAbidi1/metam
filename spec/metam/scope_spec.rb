# encoding: utf-8

require 'spec_helper'
require 'nokogiri'

describe Metam::Scope do

  before(:all) do
    @xsd = Nokogiri::XML::Schema(File.open(Metam.schema))
  end

  before(:each) do
    @scope = Metam::Scope.new('affiliation1')
  end
  context 'When XML is valid' do
    it 'create a Scope' do
      expect(@scope.klasses).not_to be_empty
    end
  end

  context 'When XML is invalid' do
    it 'raises Exception when invalid XML' do
      expect do
        Metam::Scope.new('affiliation1_faulty')
      end.to raise_error(Metam::Exceptions::InvalidXML)
    end
  end

  it 'returns a Metam::Klass' do
    expect(@scope.klass('User')).to be_a(Metam::Klass)
  end
end
