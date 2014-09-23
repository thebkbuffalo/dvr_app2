puts "running creating flags_episodes table"
Sequel.migration do
  # if we can infer
  # the opposite action we can use change

  # what we want to do
  up do
    create_table(:flags_episodes) do
      primary_key :id
      Integer :episode_id, :null => false
      Integer :series_id, :null => false
    end
  end


  # the undo
  down do
    drop_table(:flags_episodes) do
    end
  end
end
