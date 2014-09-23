puts "running creating dvrs table"
Sequel.migration do
  # if we can infer
  # the opposite action we can use change

  # what we want to do
  up do
    create_table(:dvrs) do
      primary_key :id
      Integer :serial_number, :null => false
      Integer :hard_drive_size, :null => false
      String  :zip_code, :size => 5, :null => false
    end
  end


  # the undo
  down do
    drop_table(:dvrs) do
    end
  end
end
