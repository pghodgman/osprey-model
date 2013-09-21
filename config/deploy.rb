default_run_options[:pty] = true
set :use_sudo, false
set :application, "osprey-model"
set :repository, "https://pghodgman@github.com/pghodgman/osprey-model.git"
set :branch, "master"
set :scm, :git


set :deploy_to, "/home/ec2-user/apps/#{application}"


# The address of the remote host on EC2 (the Public DNS address)
set :location, "ec2-54-211-224-42.compute-1.amazonaws.com"
# setup some Capistrano roles
role :app, location
role :web, location
role :db,  location, :primary => true

# Set up SSH so it can connect to the EC2 node - assumes your SSH key is in ~/.ssh/id_rsa
set :user, "ec2-user"
ssh_options[:keys] = [File.join(ENV["HOME"], "pubkeys", "aws-ec2.pem")]


namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop_webserver, roles => :app do
    run "#{try_sudo} service httpd stop"
  end
  task :start_webserver, roles => :app do
    run "#{try_sudo} service httpd start"
  end
end

namespace :bundle do

  desc "run bundle install and ensure all gem requirements are met"
  task :install do
    run "cd #{current_path} && bundle install"
  end
  task :update do
    run "cd #{current_path} && bundle update"
  end
end
after "deploy:update_code", "deploy:migrate"
before "deploy:restart", "bundle:install"
set :keep_releases, 10
after "deploy:restart", "deploy:cleanup"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts


# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end