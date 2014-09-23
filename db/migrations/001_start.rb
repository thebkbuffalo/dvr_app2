# db/migrations/001_start.rb

Sequel.migration do
  change do
    create_table(:stations) do
      primary_key :id
      String :name, :size=>255, :null=>false
      Integer :channel, :null=>false
      TrueClass :cable
      TrueClass :subscription
    end

    create_table(:viewers) do
      primary_key :id
      String :name, :size=>127, :null=>false
      DateTime :created_at, :default=>Sequel::CURRENT_TIMESTAMP
    end

    create_table(:series) do
      primary_key :id
      foreign_key :station_id, :stations, :null=>false, :key=>[:id]
      String :title, :size=>255, :null=>false
      DateTime :created_at, :default=>Sequel::CURRENT_TIMESTAMP
    end

    create_table(:episodes) do
      primary_key :id
      foreign_key :series_id, :series, :null=>false, :key=>[:id]
      String :tmsid, :size=>255, :null=>false
      DateTime :start_time, :null=>false
      String :short_start, :size=>127
      String :short_end, :size=>127
      Integer :length, :null=>false
      String :title, :size=>255, :null=>false
      String :description, :size=>1023
      Integer :season_number
      Integer :episode_number
      String :original_air_date, :size=>127
      DateTime :created_at, :default=>Sequel::CURRENT_TIMESTAMP
    end

    create_table(:recordings) do
      primary_key :id
      foreign_key :episode_id, :episodes, :null=>false, :key=>[:id]
      foreign_key :viewer_id, :viewers, :null=>false, :key=>[:id]
      Integer :play_head, :null=>false
      TrueClass :currently_recording
      DateTime :created_at, :default=>Sequel::CURRENT_TIMESTAMP
    end
  end
end
