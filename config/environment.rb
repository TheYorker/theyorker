# Load the rails application
require File.expand_path('../application', __FILE__)

Encoding.default_internal = 'utf-8'
Encoding.default_external = 'utf-8'

# Initialize the rails application
TheYorker::Application.initialize!
