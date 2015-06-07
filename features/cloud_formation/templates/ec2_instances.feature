Feature: CloudFormation EC2 Instance Resources
  In order to write CloudFormation templates that create EC2 instances using a Ruby DSL

  Scenario: create a single EC2 resource using inline syntax
    Given the following template snippet:
      """ruby
      resources {
        ec2_instance 'node1', image_id: 'ami-d8450c8a'
      }
      """
    Then the template in JSON should be:
      """json
      {
        "AWSTemplateFormatVersion":"2010-09-09",
        "Resources": {
          "node1": {
            "Type": "AWS::EC2::Instance",
            "Properties": {
              "ImageId": "ami-d8450c8a"
            }
          }
        }
      }
      """

  Scenario: create a single EC2 resource using block syntax
    Given the following template snippet:
      """ruby
      resources {
        ec2_instance('node1') {
          image_id 'ami-e8f1c1ba'
        }
      }
      """
    Then the template in JSON should be:
      """json
      {
        "AWSTemplateFormatVersion":"2010-09-09",
        "Resources": {
          "node1": {
            "Type": "AWS::EC2::Instance",
            "Properties": {
              "ImageId": "ami-e8f1c1ba"
            }
          }
        }
      }
      """

  Scenario: create a single EC2 resource with an inline EBS block device mapping
    Given the following template snippet:
      """ruby
      resources {
        ec2_instance('node1') {
          image_id 'ami-e8f1c1ba'
          block_device_mapping '/dev/sdb', ebs: { volume_size: "1" }
        }
      }
      """
    Then the template in JSON should be:
      """json
      {
        "AWSTemplateFormatVersion":"2010-09-09",
        "Resources": {
          "node1": {
            "Type": "AWS::EC2::Instance",
            "Properties": {
              "ImageId": "ami-e8f1c1ba",
              "BlockDeviceMappings" : [
                {
                  "DeviceName": "/dev/sdb",
                  "Ebs": { "VolumeSize" : "1" }
                }
              ]
            }
          }
        }
      }
      """
