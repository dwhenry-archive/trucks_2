File::SEPARATOR = '/'
#############################################################
#   Servers
#############################################################

set :user, "bbl"
set :password, "act?viable+acid"
set :domain,  "www.bulkbackloads.com.au"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#   Application
#############################################################

set :application, "trucks"
set :deploy_to,  "/home/#{user}/#{application}" 

#############################################################
#   Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, true
set :rails_env, "production" 

#############################################################
#   Git
#############################################################

# need to edit the file
# D:\Applications\InstantRails-2.0-win\ruby\lib\ruby\gems\1.8\gems\capistrano-2.5.8\lib\capistrano\recipes\deploy\strategy\base.rb
# around line 54...
# to gte the cap deploy to work on windows..

set :scm, :git
set :repository, "git@github.com:dwhenry/trucks_2.git"
#set :repository, "."
#set :scm, :none
#set :branch, "phase_1.1_dh"
#set :scm_user, 'daveh'
#set :scm_password, "73hDYMq$$"
#set :scm_passphrase, "----------"
set :deploy_via, :copy # :remote_cache

set :mongrel_port, "5001"                           # Mongrel port that was assigned to you
set :mongrel_nodes, "1"                             # Number of Mongrel instances for those with multiple Mongrels

#############################################################
#   Passenger
#############################################################

namespace :deploy do
#  desc "Create the database yaml file"
#  task :after_update_code do
#    db_config = <<-EOF
#    production:    
#      adapter: mysql
#      username: proton_user
#      password: proton
#      database: proton
#      socket:  /var/lib/mysqld/mysqld.sock
#    EOF
#
#    put db_config, "#{release_path}/config/database.yml"
#
#    #########################################################
#    # Uncomment the following to symlink an uploads directory.
#    # Just change the paths to whatever you need.
#    #########################################################
#
#    #desc "Symlink the assets directories"
#    # task :before_symlink do
#    #   run "mkdir -p #{shared_path}/assets"
#    #   run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
#    # end
#
#  end

  ## Restart passenger on deploy
  #desc "Restarting mod_rails with restart.txt"
  #task :restart, :roles => :app, :except => { :no_release => true } do
  #  run "touch #{current_path}/tmp/restart.txt"
  #end
  #
  #[:start, :stop].each do |t|
  #  desc "#{t} task is a no-op with mod_rails"
  #  task t, :roles => :app do ; end
  #end

end