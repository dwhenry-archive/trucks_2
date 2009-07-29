set :stages, %w(live)
require 'capistrano/ext/multistage'
load 'config/user_details'

set :application, "trucks"
default_run_options[:pty] = true

#set :scm_user, 'daveh'
#set :repository, "#{scm_user}@git.edendevelopment.co.uk:/var/git/clients/pcm/tadpole.git"
#set :scm_password, '73hDYMq$$'
#set :repository,  "ssh://git.edendevelopment.co.uk/var/git/clients/pcm/tadpole.git"

set :scm, "git"
set :deploy_via, :remote_cache

set :use_sudo, false
set :git_enable_submodules, 1


#desc 'our setup stuff'
after 'deploy:setup' do
  run <<-CMD
    mkdir -p #{shared_path}/config
  CMD
end

#desc "link in production database credentials"
after 'deploy:update_code' do
  run <<-CMD
    rm -f #{release_path}/config/database.yml &&
    ln -nfs #{shared_path}/system/database.yml #{release_path}/config/database.yml
  CMD
end
