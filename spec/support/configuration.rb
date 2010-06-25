Dir["#{File.dirname(__FILE__)}/**/*.rb"].each {|f| require f}

Spec::Runner.configure do |config|
  # Example: config.include AttributeMatchers
end