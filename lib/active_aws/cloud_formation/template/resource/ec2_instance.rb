module ActiveAws
  module CloudFormation
    class Template
      class Resource
        class Ec2Instance < Resource

          type 'AWS::EC2::Instance'

          def block_device_mappings
            properties[:block_device_mappings] ||= []
          end

          def block_device_mapping(name, options = {}, &block)
            hash = { device_name: name }
            block_device_mappings << hash.merge(options.except(:device_name))
          end
        end
      end
    end
  end
end
