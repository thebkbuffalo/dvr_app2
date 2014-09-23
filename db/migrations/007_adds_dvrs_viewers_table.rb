puts "running creating dvrs_viewers table"
Sequel.migration do
  # if we can infer
  # the opposite action we can use change

  # what we want to do
  up do
    create_table(:dvrs_viewers) do
      foreign_key :dvr_id, :dvrs, :null => false, :key => [:id]
      foreign_key :viewer_id, :viewers, :null => false, :key => [:id]
    end
  end


  # the undo
  down do
    drop_table(:dvrs_viewers) do
    end
  end
end
