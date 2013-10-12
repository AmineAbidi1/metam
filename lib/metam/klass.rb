# encoding: utf-8

module Metam

  # This class is used to store the
  class Klass
    def initialize(klass_name, xml_element)
      @name = klass_name
      @xml  = xml_element
      @attributes = {}

      @xml.xpath('attribute').each do |el|
        initialize_attribute(el)
      end
    end

    def initialize_attribute(xml_element)
      attr_name        = xml_element.xpath('title').text.downcase
      attr_validations = xml_element.xpath('validators/*').reduce({}) do |hsh, validation|
        hsh.update(validation.name => validation.text)
      end

      @attributes[attr_name] = Metam::Attribute.new(attr_name, attr_validations)
    end

    def attribute(attribute_name)
      @attributes[attribute_name.to_s]
    end

    def attribute_names
      @attributes.keys
    end

    def attributes
      @attributes.values
    end
  end
end
