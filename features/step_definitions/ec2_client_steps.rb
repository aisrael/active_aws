Given(/^An ActiveAws EC2 client$/) do
  @it = @ec2 = ActiveAws::EC2::Client.new
end

Then(/^(?:it's|the) (first|last) ([^']+)'s ([^ ]+) should be "([^"]*)"$/) do |first_or_last, collection, attribute, expected|
  step %Q{`@it.#{collection.gsub(/\s+/,'_').tableize}.#{first_or_last}.#{attribute}` should be "#{expected}"}
end
