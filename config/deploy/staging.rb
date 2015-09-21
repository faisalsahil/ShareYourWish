set :application, "shareyourwish"
set :repository, "git@github.com:eputter/ShareYourWish.git"
set :scm, :git
set :branch, "staging"
set :deploy_to, "/usr/local/code/shareyourwish_staging"
role :app, "shareyourwish.com" 
role :web, "shareyourwish.com" 
role :db, "shareyourwish.com", :primary  => true
set :user, "root"
set :use_sudo, false
require "bundler/capistrano"
set :bundle_gemfile,  "Gemfile"
set :bundle_dir,      File.join(fetch(:shared_path), 'bundle')
set :bundle_flags,    "--deployment --quiet"
set :bundle_without,  [:development, :test]
set :rails_env, "production"  #don't know what changed recently to require this, w/o it rails_env=staging which is invalid

#set :bundle_cmd,      "bundle" # e.g. "/opt/ruby/bin/bundle"
#set :bundle_roles,    {:except => {:no_release => true}} # e.g. [:app, :batch]

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :copy_env_files do
    run "cp #{shared_path}/system/database.yml #{release_path}/config/database.yml"
    run "cp #{shared_path}/system/config.yml #{release_path}/config/config.yml"
    run "cp #{shared_path}/system/braintree_prod.rb #{release_path}/config/initializers/braintree_prod.rb"
  end  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
     run "chgrp nobody #{current_path}/tmp"
     run "chmod g+w #{current_path}/tmp"
     run "chgrp -R nobody #{current_path}/tmp/cache"
     run "chmod -R g+w #{current_path}/tmp/cache"
     run "chgrp nobody #{current_path}/public"  # I don't like this but it's to generate the err pages
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
 
end

before "deploy:assets:precompile", "deploy:copy_env_files"


