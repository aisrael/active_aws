WORKING_DIR = File.join %w(tmp aruba)

def in_dir(dir, &block)
  pwd = Dir.pwd
  begin
    Dir.chdir dir
    block.call
  ensure
    Dir.chdir pwd
  end
end

Given(/^the following code snippet:$/) do |snippet|
  in_dir WORKING_DIR do
    eval snippet
  end
end

Given(/^the following template snippet:$/) do |snippet|
  @template = ActiveAws::CloudFormation::Template.new do
    eval snippet
  end
end

When(/^I execute `([^`]+)`/) do |snippet|
  eval(snippet)
end

Then(/^it should have (\d+) (.+)$/) do |value, something|
  expect(@it.send(something.gsub(/\s+/,'_').tableize.intern).count).to eq(value.to_i)
end

Then(/^`(\S+)` should have (\d+) (\S+)$/) do |subject, value, something|
  step "`#{subject}.#{something.pluralize}.count` should be #{value}"
end

Then(/^the (first|last) ([^']+)'s (\S+) should be `"([^"]*)"`$/) do |first_or_last, collection, attribute, expected|
  step %Q{`#{collection.gsub(/\s+/,'_').tableize}.#{first_or_last}.#{attribute}` should be "#{expected}"}
end

Then(/^the "(\S+)" (\S+)'s `.([^`]+)` should be `"([^"]*)"`$/) do |element_name, collection, attribute, expected|
  step %Q{`#{collection.pluralize}['#{element_name}'].#{attribute}` should be `"#{expected}"`}
end

Then(/^the "(\S+)" (\S+)'s ([^`]\S*) should be `"([^"]*)"`$/) do |element_name, collection, attribute, expected|
  step %Q{the "#{element_name}" #{collection}'s `.#{attribute}` should be `"#{expected}"`'}
end

Then(/^the (first|last) (\S+) should have (\d+) (\S+)$/) do |first_or_last, collection, n, sub_collection|
  step %Q{`#{collection.pluralize}.#{first_or_last}.#{sub_collection.pluralize}.count` should be #{n}}
end

Then(/^the "(\S+)" (\S+) should have (\d+) (\S+)$/) do |element_name, collection, n, sub_collection|
  step %Q{`#{collection.pluralize}['#{element_name}'].#{sub_collection.pluralize}.count` should be #{n}}
end

Then(/^the `([^`]+)` should be:$/) do |something, expected|
  actual = eval(something)
  expect(actual).to eq(expected)
end

Then(/^the template in JSON should be:$/) do |text|
  actual_json = @template.to_json
  expected_equivalent = JSON::parse!(text).to_json
  expect(actual_json).to eq(expected_equivalent)
end

Then(/^`([^`]+)` should be "([^"]+)"$/) do |something, string|
  # Yes, we use eval. It should be safe (do we need a test for that?)
  actual = eval(something).to_s
  expect(actual).to eq(string)
end

Then(/^`([^`]+)` should be (\d+)$/) do |something, value|
  # Yes, we use eval. It should be safe (do we need a test for that?)
  actual = eval(something).to_i
  expected = value.to_i
  expect(actual).to eq(expected)
end
