namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler'
  end
end

task :environment, [:env] => 'bundler:setup' do |cmd, args|
  ENV["RACK_ENV"] = args[:env] || "development"
  Bundler.require(:default, ENV["RACK_ENV"])
  require "./config/boot"
end

namespace :db do
  desc "creates a db"
  task :create, [:env] do |cmd, args|
    env = args[:env] || "development"
    dbname = "dvr_app"
    sh("createdb #{dbname}_#{env}")
  end

  desc "drop db"
  task :drop, [:env] do |cmd, args|
    env = args[:env] || "development"
    dbname = "dvr_app"
    sh("dropdb #{dbname}_#{env}")
  end

  desc "seed db"
  task :seed, [:env] do |cmd, args|
    # default environment
    env = args[:env] || "development"
    # load up my sinatra environment
    # then populate my database
    # calls rake environment[env]
    Rake::Task['environment'].invoke(env)
    require './db/seeds'
  end
end