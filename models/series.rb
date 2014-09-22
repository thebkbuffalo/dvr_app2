# id         serial       PRIMARY KEY,
# station_id integer      REFERENCES stations(id) NOT NULL,
# title      varchar(255) NOT NULL
class Series < Sequel::Model
  one_to_many(:episodes)
  many_to_one(:station)
end
