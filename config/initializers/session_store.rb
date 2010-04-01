# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Schedule_session',
  :secret      => 'c8433b9887ef27c5f5f8a0c6cd996a72d14875881b6281182ce086280c6baa550b6ed79ee0abe5517170804975c75bf1646613b378e6e50dfe914cb80b372219'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
