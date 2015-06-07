Given(/^An ActiveAws EC2 client$/) do
  @it = @ec2 = ActiveAws::EC2::Client.new
end
