require 'active_support/dependencies/autoload'
require 'active_support/deprecation'
require 'active_support/core_ext'

require 'aws-sdk'

module ActiveAws

  autoload :ParameterizedInitializer, 'active_aws/parameterized_initializer'
  autoload :CloudFormation, 'active_aws/cloud_formation'
  autoload :EC2, 'active_aws/ec2'

end
