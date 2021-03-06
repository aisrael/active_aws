require 'ostruct'

module ActiveAws
  module CloudFormation
    class Template

      # Returns a block that acts as a facade for the given target, allowing
      # calls of the form
      #
      #    attribute 'value'
      #
      # and transforms them into the equivalent
      #
      #    @target.attribute = 'value'
      class DSLBlock
        include Referrer

        attr_reader :target
        def initialize(target)
          @target = target
        end

        def method_missing(method_name, *args)
          if args.size == 0 && (target.is_a?(OpenStruct) || @target.respond_to?(method_name))
            return @target.send(method_name)
          elsif args.size == 1
            if @target.is_a?(Hash)
              return @target.store(method_name, args.first)
            else
              setter = "#{method_name}=".to_sym
              if @target.is_a?(OpenStruct) || @target.respond_to?(setter)
                return @target.send(setter, args.first)
              end
            end
          end
          # fall back to super
          super
        end

        class << self
          def eval_using(target, block)
            DSLBlock.new(target).instance_eval(&block)
          end
        end
      end
    end
  end
end
