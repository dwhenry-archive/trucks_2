puts "Deploying to #{stage.to_s.upcase} site"

if ENV['location'] && ENV['location'].downcase == 'local'
  set :server_hostname, "localhost"
end

role :web, server_hostname
role :app, server_hostname
role :db,  server_hostname, :primary => true

