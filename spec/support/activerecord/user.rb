# encoding: utf-8

module Support
  module Activerecord
    class User < ActiveRecord::Base
      serialize :metadata, Hash

      metamodel scope: ->(user) { user.affiliation }, store: :metadata
    end
  end
end
