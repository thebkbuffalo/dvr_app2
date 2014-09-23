# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# require libs
require 'zip'
require 'sequel'
require 'yaml'

# connect to db
DB = Sequel.connect("postgres://localhost/dvr_app_development")

# require models (important to do this after connecting to the DB, remember!)
Dir["../models/*.rb"].each {|file| require file }

# clean it out!
Episode.dataset.destroy
Series.dataset.destroy
Station.dataset.destroy

# get raw stations data
raw_stations = YAML.load File.read('../data/stations.yaml')

Station.unrestrict_primary_key # we are setting the KEY here, so you have to call this

# iterate and insert
raw_stations.each do |raw_station|
  Station.create(
    id:           raw_station[:channel_id].to_i,
    name:         raw_station[:name],
    channel:      raw_station[:number],
    cable:        raw_station[:cable],
    subscription: raw_station[:subscription]
  )
end

###########################
# now we have to do the rest
#  of the datasets from the
#  episode file!
###########################

# open up the zip file as a stream
zip_stream = nil # declare outside of block so that it has file local scope...
                 #   ie, we can access it after we close the block!
Zip::File.open('../data/episodes.yaml.zip') do |zip_file|
  # derived from https://github.com/rubyzip/rubyzip
  zip_stream = zip_file.entries[0].get_input_stream
end

# get raw episodes data
raw_episodes = YAML.load zip_stream.read

# break out JUST the :program_title, ie the name of the series the episode is a
#  part of, and the station (channel id or 'cid') it is on...
raw_series = raw_episodes.map do |episode|
  {
    station_id: episode[:cid].to_i,
    title:      episode[:program_title]
  }
end

# take only one entry from each series (there will be one for each episode in
#  the series by default), and iterate thru...
raw_series = raw_series.uniq
total      = raw_series.length                # get total for loggin below!
raw_series.each_with_index do |series, index| # get index for logging below!
  series = Series.create(
    title:      series[:title],
    station_id: series[:station_id]
  )

  # now that we have series, let's add our episodes to them!
  #  this may not have seemed like the most straightofrward way of doing it, but
  #  essentially, if there is a one-to-many relationship, the "many" side is said
  #  to *belong to* the "one" side. in that case, we need to add any data first
  #  that other data belongs to. since episodes belong to series, we need to add
  #  the series first

  # so we select, or pull out, just the episodes for the series we just added...
  this_series_episodes = raw_episodes.select do |episode|
    episode[:cid].to_i == series.station.id && episode[:program_title] == series.title
  end

  # log to screen, bc this takes a long time and looking at a blank screen for a
  #  long time is boring or scary
  puts "Adding episodes for #{series.title} on #{series.station.name}..." + \
       " (#{index+1} of #{total})"

  # then we iterate over these episodes and add them to the db!
  this_series_episodes.each do |episode|
    Episode.create(
      series_id:         series.id, # from above
      tmsid:             episode[:tmsid],
      title:             episode[:episode_title],
      description:       episode[:description],
      start_time:        Time.parse(episode[:full_start_time]),
      short_start:       episode[:short_start_time],
      short_end:         episode[:short_end_time],
      length:            episode[:length].to_i,
      season_number:     episode[:season],
      episode_number:    episode[:episode],
      original_air_date: episode[:original_air_date]
    )
  end
end

###########################
# finally, it gets easy again!
###########################

Viewer.create(name: "PJ")
Viewer.create(name: "Christie")
