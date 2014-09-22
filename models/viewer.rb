# id   serial       PRIMARY KEY,
# name varchar(127) NOT NULL

class Viewer < Sequel::Model
  one_to_many(:recordings)
end
