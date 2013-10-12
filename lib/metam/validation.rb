# encoding: utf-8

require 'uri'
require 'date'
module Metam

  #
  # [ module description]
  #
  # @author [author]
  #
  module Validation

    #
    # [ class description]
    #
    # @author [author]
    #
    class Core
      class << self

        #
        # [validate description]
        # @param  klass [type] [description]
        # @param  instance [type] [description]
        #
        # @return [type] [description]
        def validate(klass, instance)
          klass.attributes.each do |attr|
            attr.validations.each do |validation, setting|
              implementation = build(instance, attr, validation, setting)
              implementation.perform
            end
          end
        end

        private

        def build(instance, attr, validation_name, setting)
          implementation = "Metam::Validation::#{validation_name.camelcase}".constantize
          implementation.new(instance, attr.name, setting)
        end
      end

      def initialize(instance, instance_attr, setting = '')
        @instance = instance
        @attr     = instance_attr
        @setting  = setting
      end

      def val
        @instance.send(@attr)
      end

      def failed(reason)
        @instance.errors.add(@attr, reason)
      end
    end

    #
    # This class check the Presence of a particular
    #
    # @author [author]
    #
    class Presence < Core
      def perform
        return if @setting == 'false'
        failed(:blank) if val.blank?
      end
    end

    #
    # [ class description]
    #
    # @author [author]
    #
    class Datatype < Core

      def perform
        send "validate_#{@setting}", val
      end

      def validate_string(val)
        failed(:invalid_datatype_string) unless val.is_a?(String)
      end

      def validate_url(val)
        failed(:invalid_datatype_url) unless val =~ /^#{URI.regexp}$/
      end

      def validate_email(val)
        failed(:invalid_datatype_email) unless val =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      end

      def validate_integer(val)
        failed(:invalid_datatype_integer) unless val.is_a?(Integer)
      end

      def validate_float(val)
        failed(:invalid_datatype_float) unless val =~ /\A\d+\.\d+$/
      end

      def validate_date(val)
        failed(:invalid_datatype_date) unless begin
                                                  Date.parse(val)
                                                rescue
                                                  false
                                                end
      end

      def validate_datetime(val)
        failed(:invalid_datatype_datetime) unless begin
                                                  DateTime.parse(val)
                                                rescue
                                                  false
                                                end
      end

      def validate_telephone(val)
        failed(:invalid_datatype_telephone) unless val =~ /\A^\+[0-9]{6,}$/
      end

      def validate_percentage(val)
        failed(:invalid_datatype_percentage) unless val =~ /\A[0-9]{1,3}$/ && val.to_i.between?(0, 100)
      end

      def validate_multiple(val)
        arr = val.to_s.split(',').map(&:strip)
        failed(:invalid_multiple_values) if arr.empty?
      end
    end

    #
    # [ class description]
    #
    # @author [author]
    #
    class Maxlength < Core
      def perform
        failed(:invalid_maxlength) if val.to_s.length > @setting.to_i
      end
    end

    #
    # [ class description]
    #
    # @author [author]
    #
    class Minlength < Core
      def perform
        failed(:invalid_minlength) if val.to_s.length < @setting.to_i
      end
    end

    #
    # [ class description]
    #
    # @author [author]
    #
    class Precision < Core
      def perform
        unless val.nil?
          precision = (val.to_s.split('.'))[1].length
          failed(:invalid_floating_number_precision) if precision > @setting.to_i
        end
      end
    end

    #
    # [ class description]
    #
    # @author [author]
    #
    class Maxvalues < Core
      def perform
        failed(:invalid_maximum_number_of_values) if val.to_s.split(',').map(&:strip).size > @setting.to_i
      end
    end

  end
end
