Feature: CloudFormation Template Writing
  In order to write CloudFormation templates using a Ruby DSL rather than JSON

  Scenario: create a blank template
    Given the following code snippet:
      """ruby
      @template = ActiveAws::CloudFormation::Template.new do
      end
      """
    Then the template in JSON should be:
      """json
      {
        "AWSTemplateFormatVersion":"2010-09-09"
      }
      """

  Scenario: create a template with a description
    Given the following code snippet:
      """ruby
      @template = ActiveAws::CloudFormation::Template.new do
        description "Template description"
      end
      """
    Then the template in JSON should be:
      """json
      {
        "AWSTemplateFormatVersion": "2010-09-09",
        "Description": "Template description"
      }
      """

  Scenario: create a complex CloudFormation template
    Given the following code snippet:
      """ruby
      @template = ActiveAws::CloudFormation::Template.new do
        description 'Cloud Formation template'

        # Define parameters one by one
        parameter 'KeyName', :string, description: 'The key name to use to connect to the instances'

        # Or use a parameters 'block' for some syntatic sugar
        parameters {
          string 'AvailabilityZone', description: 'The availability zone to create instances in'

          # Also accepts a block
          string 'InstanceType' do
            allowed_values %w(t1.micro m1.small m1.medium m1.large)
            description "EC2 instance type (e.g. #{allowed_values.join(', ')})"
            default 't1.micro'
          end
        }

        # You can also add mappings in a mappings {} block
        mapping 'RegionMap', {
          'us-east-1' => { '32' => 'ami-6411e20d'},
          'us-west-1' => { '32' => 'ami-c9c7978c'},
          'eu-west-1' => { '32' => 'ami-37c2f643'},
          'ap-southeast-1' => { '32' => 'ami-66f28c34', '64' => 'ami-e8f1c1ba' },
          'ap-northeast-1' => { '32' => 'ami-9c03a89d'}
        }

        resources {
          ec2_instance 'AppInstance1' do
            availability_zone Ref: 'AvailabilityZone'
            image_id 'ami-e8f1c1ba'
            instance_type Ref: 'InstanceType'
          end
          load_balancer 'LoadBalancer' do
            availability_zones Ref: 'AvailabilityZone'
            listener 'HTTP', 80, 'HTTP', 80
            instances Ref: 'AppInstance1'
          end
        }
      end
      """
    Then the template in JSON should be:
      """json
      {
        "AWSTemplateFormatVersion": "2010-09-09",
        "Description": "Cloud Formation template",
        "Parameters": {
          "KeyName": {
            "Type": "String",
            "Description": "The key name to use to connect to the instances"
          },
          "AvailabilityZone": {
            "Type": "String",
            "Description": "The availability zone to create instances in"
          },
          "InstanceType": {
            "Type": "String",
            "Description": "EC2 instance type (e.g. t1.micro, m1.small, m1.medium, m1.large)",
            "Default": "t1.micro",
            "AllowedValues": [
              "t1.micro",
              "m1.small",
              "m1.medium",
              "m1.large"
            ]
          }
        },
        "Mappings": {
          "Mappings": {
            "RegionMap": {
              "us-east-1": {
                "32": "ami-6411e20d"
              },
              "us-west-1": {
                "32": "ami-c9c7978c"
              },
              "eu-west-1": {
                "32": "ami-37c2f643"
              },
              "ap-southeast-1": {
                "32": "ami-66f28c34",
                "64": "ami-e8f1c1ba"
              },
              "ap-northeast-1": {
                "32": "ami-9c03a89d"
              }
            }
          }
        },
        "Resources": {
          "AppInstance1": {
            "Type": "AWS::EC2::Instance",
            "Properties": {
              "AvailabilityZone": {
                "Ref": "AvailabilityZone"
              },
              "ImageId": "ami-e8f1c1ba",
              "InstanceType": {
                "Ref": "InstanceType"
              }
            }
          },
          "LoadBalancer": {
            "Type": "AWS::ElasticLoadBalancing::LoadBalancer",
            "Properties": {
              "AvailabilityZones": [
                {
                  "Ref": "AvailabilityZone"
                }
              ],
              "Listeners": [
                {
                  "Protocol": "HTTP",
                  "LoadBalancerPort": 80,
                  "InstanceProtocol": "HTTP",
                  "InstancePort": 80
                }
              ],
              "Instances": {
                "Ref": "AppInstance1"
              }
            }
          }
        }
      }
      """
