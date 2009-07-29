
namespace :deploy do
  desc "Override the restart to do the passenger thing"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Override the start to do the passenger thing"
  task :start, :roles => :app do

  end
end

