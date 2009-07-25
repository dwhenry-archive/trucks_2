# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_trucks2_session',
  :secret      => '139d68d298347ff2466ebfb03456aed377b810e3168a2c45a04ba3c2f7dbbfb3c2af1ec11d4d8044da47913c35f27d806dfc94af1fe47cfbc666beca17d2d108'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
