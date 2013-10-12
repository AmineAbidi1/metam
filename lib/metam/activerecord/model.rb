# encoding: utf-8

module Metam
  module Activerecord
    module Model
      module ClassMethods
        attr_reader :metamodel_opts

        def metamodel(opts = {})
          @metamodel_opts = opts

          # load metamodel methods
          send(:include, InstanceMethods)

          # setup metamodel callbacks for this class
          class_eval do
            after_initialize do
              metadata_accessors
            end

            validate do |instance|
              instance.metadata_validate
            end
          end
        end
      end

      module InstanceMethods
        def metamodel_scope
          self.class.metamodel_opts[:scope].call(self)
        end

        def metamodel_klass
          scope = Metam::Store.instance.scope(metamodel_scope)
          scope.klass(self.class.base_class.name.demodulize)
        end

        def metamodel_store
          send self.class.metamodel_opts[:store]
        end

        protected

        # defines getters and setters for all metamodel attributes
        # on the concrete model instance
        def metadata_accessors
          metamodel_klass.attributes.each do |attribute|
            next if respond_to?(attribute.name)

            define_singleton_method(attribute.name) do
              metamodel_store[attribute.name]
            end

            define_singleton_method("#{attribute.name}=") do |value|
              metamodel_store[attribute.name] = value
            end
          end
        end

        def metadata_validate
          Metam::Validation::Core.validate(metamodel_klass, self)
        end

        # patching rails to avoid UnknownAttribute errors
        # the idea is to catch all failing attribute assignments and
        # to execute them again once the model is ready for it
        def assign_attributes(new_attributes)
          return if new_attributes.blank? # already defined

          attributes                  = new_attributes.stringify_keys
          multi_parameter_attributes  = []
          nested_parameter_attributes = []
          failed_assignments          = {}

          attributes = sanitize_for_mass_assignment(attributes)

          attributes.each do |k, v|
            if k.include?('(')
              multi_parameter_attributes << [k, v]
            elsif v.is_a?(Hash)
              nested_parameter_attributes << [k, v]
            else
              begin
                _assign_attribute(k, v)
              rescue ActiveRecord::UnknownAttributeError
                failed_assignments.update(k => v)
              end
            end
          end

          assign_nested_parameter_attributes(nested_parameter_attributes) unless nested_parameter_attributes.empty?
          assign_multiparameter_attributes(multi_parameter_attributes) unless multi_parameter_attributes.empty?

          reassign_attributes(failed_assignments)
        end

        def reassign_attributes(new_attributes)
          metadata_accessors

          new_attributes.each do |attr, value|
            send("#{attr}=", value)
          end
        end
      end
    end
  end
end
