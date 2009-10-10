# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fourbi_session',
  :secret      => '5fdc2cd0f77369ae810c626d76ab55c7812c3112286eda8e583d261aae19a0a38ea443e7b7620f63dc4856f4088867824bd597ab7711dc9dca9c90aa608b9652'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
