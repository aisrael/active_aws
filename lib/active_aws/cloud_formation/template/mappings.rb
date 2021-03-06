module ActiveAws
  module CloudFormation
    class Template
      class Mappings < DelegateClass(Hash)
        def initialize
          super(@mappings = {})
        end

        def map(name, mapping = {}, &block)
          raise 'Mappings only accepts a Hash as values' unless mapping.is_a? Hash
          @mappings[name] = mapping
          yield mapping if block_given?
          mapping
        end

        def to_h
          {'Mappings' => @mappings}
        end
      end
    end
  end
end
