# # encoding: utf-8

# Inspec test for recipe apache::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(80) do
  it{should be_listening}
end

describe package('apache2') do
  it{should be_installed}
end

describe file('/var/www/html/index.html') do
  it{should exist}
  its('content'){should match(/Hello Pipeline World!/)}
end

describe upstart_service('apache2') do
  it{should be_enabled}
  it{should be_running}
end
# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end
