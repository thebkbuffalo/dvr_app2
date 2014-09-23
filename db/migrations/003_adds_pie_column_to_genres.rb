Sequel.migration do
  change do
    alter_table(:genres) do
      add_column(:pie, String)
    end
  end
end
