Feature: Parameterized Initializer module
  In order to write initializers that accept a hash of attribute: value pairs easier.

  Scenario: Using it
    Given the following code snippet:
      """ruby
      class Point
        include ActiveAws::ParameterizedInitializer

        attr_accessor :x, :y
      end
      """
    When I execute `@point = Point.new x: 2, y: 3`
    Then `@point.x` should be 2
    And `@point.y` should be 3
