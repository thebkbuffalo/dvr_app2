# id           serial       PRIMARY KEY,
# name         varchar(255) NOT NULL,
# channel      integer      NOT NULL,
# cable        boolean,
# subscription boolean
class Station < Sequel::Model
  one_to_many(:series)
end

