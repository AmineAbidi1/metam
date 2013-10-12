# encoding: utf-8

require 'active_support/core_ext'

Dir.glob(File.join(File.expand_path(File.dirname(__FILE__)), 'metam/**/*')).each do |file|
  require file unless File.directory?(file)
end

module Metam
  mattr_accessor :data_dir, :schema
end

if defined? ActiveRecord::Base
  ActiveRecord::Base.send(:extend, Metam::Activerecord::Model::ClassMethods)
end
