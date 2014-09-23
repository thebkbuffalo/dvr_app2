puts "running creating genre_series table"
Sequel.migration do
  # if we can infer
  # the opposite action we can use change

  # what we want to do
  up do
    create_table(:genres_series) do
      primary_key :id
      Integer :series_id, :null => false
      Integer :genre_id, :null => false
    end
  end


  # the undo
  down do
    drop_table(:genres_series) do
    end
  end
end
