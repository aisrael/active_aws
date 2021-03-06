module ActiveAws
  module EC2
    class Client
      def initialize
        @ec2 = Aws::EC2::Client.new
      end

      def regions
        @regions ||= begin
          @ec2.describe_regions.regions
        end
      end

      def instances
        @instances ||= begin
          @ec2.describe_instances.reservations.flat_map(&:instances)
        end
      end

      def availability_zones
        @availability_zones ||= begin
          @ec2.describe_availability_zones.availability_zones
        end
      end
    end
  end
end
