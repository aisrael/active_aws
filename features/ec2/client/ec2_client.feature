Feature: ActiveAws EC2 client
  In order to have a better EC2 client

  @ec2
  Scenario: It has `.regions`
    Given An ActiveAws EC2 client
    Then it should have 9 regions

  @ec2
  Scenario: It has `.instances`
    Given An ActiveAws EC2 client
    Then it should have 1 instances

  @ec2
  Scenario: It has `.availability_zones`
    Given An ActiveAws EC2 client
    Then it should have 2 availability zones
    And the first availability zone's zone_name should be "ap-southeast-1a"
    And the last availability zone's zone_name should be "ap-southeast-1b"
