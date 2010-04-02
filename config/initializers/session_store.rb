# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_fourbi_session',
  :secret => '75535ea613065045732a807afbdf2c459e1fcc5154394d6db1caa19f393c165d04cc099c51bb2b9ec20ac70ff5b291c320a217b81a8728fc07fb1089a1851b72'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
