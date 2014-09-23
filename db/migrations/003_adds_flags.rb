puts "creates flags table"
Sequel.migration do
  # if we can infer
  # the opposite action we can use change

  # what we want to do
  up do
    create_table(:flags) do
      primary_key :id
      String :name, :size => 127, :null => false
    end
  end

  down do
    drop_table(:flags) do
    end


end
