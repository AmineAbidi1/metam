# encoding: utf-8

require 'spec_helper'
require 'support/activerecord/user'

describe Metam::Activerecord::Model do

  before(:each) do
    @user = Support::Activerecord::User.new
  end

  it 'responds to :affiliation' do
    expect(@user).to respond_to(:affiliation)
  end

  it 's default affiliation is affiliation1' do
    expect(@user.affiliation).to eq('affiliation1')
  end

  describe '#metamodel_klass' do
    it 'returns the metamodel klass definition' do
      expect(@user.metamodel_klass).to be_a(Metam::Klass)
    end
  end

  context 'When scope is not available' do
    it 'should fail' do
      expect do
        Support::Activerecord::User.new(affiliation: nil, name: 'foo')
      end.to raise_error(Metam::Exceptions::UnknownScope)
    end
  end

  context 'When scope is not valid' do
    it 'should fail' do
      expect do
        Support::Activerecord::User.new(affiliation: 'affiliation1_faulty', name: 'foo')
      end.to raise_error(Metam::Exceptions::InvalidXML)
    end
  end

  describe '#metamodel_scope' do
    it 'returns affiliation1' do
      expect(@user.metamodel_scope).to eq('affiliation1')
    end
  end

  describe 'setters/getters' do

    it 'responds to :name' do
      expect(@user).to respond_to(:name)
    end

    it 'returns the name' do
      @user.metadata['name'] = 'john'
      expect(@user.name).to eq('john')
    end

    it 'sets the name' do
      expect do
        @user.name = 'john'
      end.not_to raise_error

      expect(@user.name).to eq('john')
    end

    it 'initializes the instance with the given metadata values' do
      user = Support::Activerecord::User.new(name: 'amine')

      expect(user.name).to eq('amine')
    end
  end

  describe 'validations' do
    it 'should call meta validations' do
      expect(@user).to receive(:metadata_validate)
      @user.valid?
    end

    it 'initializes required validations' do
      validation = double('validation', perform: true)
      expect(Metam::Validation::Presence).to receive(:new).and_return(validation).at_least(:once)
      expect(Metam::Validation::Datatype).to receive(:new).and_return(validation).at_least(:once)
      expect(Metam::Validation::Precision).to receive(:new).and_return(validation).at_least(:once)

      @user.valid?
    end

    # TODO: be more specific here...
    it 'should be invalid' do
    end
  end
end
