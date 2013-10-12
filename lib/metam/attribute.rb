# encoding: utf-8

module Metam

  # This class is used to store the attributes related to a particular {Metam::Klass} class.
  # Each attribute is represented by a name and a set of validation rules.
  class Attribute
    attr_reader :name, :validations

    def initialize(name, validations)
      @name = name
      @validations = validations
    end
  end
end
