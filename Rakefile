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

  desc "creates db, applies migrations, seeds db"
  task :setup, [:env] do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['db:drop'].invoke(env)
    Rake::Task['db:create'].invoke(env)
    Rake::Task['db:migrate'].invoke(env)
    Rake::Task['db:seed'].invoke(env)
  end

<<<<<<< HEAD
  desc "Run database migrations"
  task :migrate, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    require 'sequel/extensions/migration'
    # apply database, migration_folder
    Sequel::Migrator.apply(DB, "db/migrations")
  end

   desc "Rollback the database"
   task :rollback, :env do |cmd, args|
=======
  desc "Rollback the database"
  task :rollback, :env do |cmd, args|
>>>>>>> d82351cbbb382d758659fe3309f600dccc4babfe
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    require 'sequel/extensions/migration'
    version = (row = DB[:schema_info].first) ? row[:version] : nil
    Sequel::Migrator.apply(DB, "db/migrations", version - 1)
  end

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

<<<<<<< HEAD
  desc "seed db"
=======
  desc "Run database migrations"
  task :migrate, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    require 'sequel/extensions/migration'
    # apply database, migration_folder
    # runs all migration files in db/migrations
    # generated first schema with
    # sequel postgres://localhost/dvr_app_development -d
    Sequel::Migrator.apply(DB, "db/migrations")
  end

  desc "seed db"
  # $ rake db:seed
  # $ rake db:seed[test]
  # $ rake db:seed[production]
>>>>>>> d82351cbbb382d758659fe3309f600dccc4babfe
  task :seed, [:env] do |cmd, args|
    # default environment
    env = args[:env] || "development"
    # load up my sinatra environment
    # then populate my database
    # calls rake environment[env]
    Rake::Task['environment'].invoke(env)
<<<<<<< HEAD
    require './db/seeds'
  end
end
=======
    Rake::Task['milkshakes'].invoke
    require './db/seeds'
  end
end

task :milkshakes do
  puts "come hither"
end







>>>>>>> d82351cbbb382d758659fe3309f600dccc4babfe
