# id                  serial  PRIMARY KEY,
# episode_id          integer REFERENCES episodes(id) NOT NULL,
# play_head           integer NOT NULL, -- place in recording in seconds
# currently_recording boolean

class Recording < Sequel::Model
  many_to_one(:viewers)
end
