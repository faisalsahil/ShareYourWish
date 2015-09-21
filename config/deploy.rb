set :stages, %w(production staging)
set :default_stage, "staging"
set :deploy_via, :remote_cache
require 'capistrano/ext/multistage'
require './config/boot'
require 'airbrake/capistrano'

