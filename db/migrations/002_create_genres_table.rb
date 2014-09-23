<<<<<<< HEAD
Sequel.migration do
=======
puts "running creating genres table"
Sequel.migration do
  # if we can infer
  # the opposite action we can use change
>>>>>>> 9a654b0288569910325409db1ce4220cfbaf92b4
  # what we want to do
  up do
    create_table(:genres) do
      primary_key :id
      String :name, :size => 127, :null => false
    end
  end


  # the undo
    drop_table(:genres)
  end
end
