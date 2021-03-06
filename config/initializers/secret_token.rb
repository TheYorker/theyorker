# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
secret_file = File.join(ENV['HOME'], "secret")
if File.exist?(secret_file)
  secret = File.read(secret_file)
else
  secret = ActiveSupport::SecureRandom.hex(64)
  File.open(secret_file, 'w') { |f| f.write(secret) }
end

TheYorker::Application.config.secret_token = secret


# TheYorker::Application.config.secret_token = '10e683c90506cb708a2c85d313e381c7c038f4e552cfa940bad5e6b0d18b5cb36ceee2697d0e5601a8ac2eff16d8ae8a45a68550e1b6640b9e5075f9652c76d6'
