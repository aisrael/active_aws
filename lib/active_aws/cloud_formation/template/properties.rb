require 'active_support/concern'

module ActiveAws
  module CloudFormation
    class Template

      class Properties < Hash
        def add(name, value)
          store(name, value)
        end
        def method_missing(method_name, *args, &block)
          if has_key?(method_name)
            fetch(method_name)
          else
            super
          end
        end
      end

      # See http://ruby-doc.org/core-2.2.0/Struct.html
      PropertyDefinition = Struct.new :name, :type
      class PropertyDefinition
        class Collection < Array
          def add(name, type)
            puts "PropertyDefinition::Collection.add(#{name},#{type})"
            self.push(PropertyDefinition.new(name,type))
          end
        end
      end

      # The basis of almost all CloudFormation resources and embedded properties
      module HasProperties
        extend ActiveSupport::Concern

        PRIMITIVE_PROPERTY_TYPES = %i(string boolean integer)

        included do
        end

        class_methods do
          def properties(*args, &block)
            puts("properties(#{args})")
            if args.empty?
              @@properties ||= PropertyDefinition::Collection.new
              puts("@@properties => #{@@properties || 'nil'}")
            else
              if args.first.is_a?(Hash)

              end
            end
            if block_given?
              DSL.new(self).instance_eval(&block)
            end
            @@properties
          end
        end

        private

        class DSL
          def initialize(base_class)
            puts("DSL.initialize(#{base_class})")
            @base_class = base_class
          end
          def string(name)
            puts("DSL.string(#{name})")
            @base_class.properties.add name, :string
            @base_class.send(:define_method, "#{name}=") { |value| instance_variable_set("@#{name}", value)}
            @base_class.send(:define_method, name) { instance_variable_get("@#{name}")}
          end
        end
      end

      class OpenStructWithProperties < OpenStruct
        include HasProperties
      end

    end
  end
end
