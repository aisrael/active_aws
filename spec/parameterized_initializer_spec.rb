require 'rspec'

require 'active_aws/parameterized_initializer'

describe ActiveAws::ParameterizedInitializer do

  it 'provides a default initializer' do

    class Point
      include ActiveAws::ParameterizedInitializer

      attr_accessor :x, :y
    end

    point = Point.new x: 2, y: 3

    expect(point.x).to eq(2)
    expect(point.y).to eq(3)
  end
end
