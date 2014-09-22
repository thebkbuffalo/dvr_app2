# id                serial       PRIMARY KEY,
# series_id         integer      REFERENCES series(id) NOT NULL,
# tmsid             varchar(255) NOT NULL,
# start_time        timestamp with time zone NOT NULL,
# short_start       varchar(127),
# short_end         varchar(127),
# length            integer      NOT NULL,
# title             varchar(255) NOT NULL,
# description       varchar(1023),
# season            integer,
# episode           integer,
# original_air_date varchar(127)

class Episode < Sequel::Model
  many_to_many(:viewers)
  one_to_one(:recording)
end
