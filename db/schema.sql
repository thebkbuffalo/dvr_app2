DROP DATABASE IF EXISTS dvr_app_development;
CREATE DATABASE dvr_app_development;
\c dvr_app_development

DROP TABLE IF EXISTS stations;
DROP TABLE IF EXISTS series;
DROP TABLE IF EXISTS episodes;
DROP TABLE IF EXISTS recordings;
DROP TABLE IF EXISTS viewers;

CREATE TABLE stations (
  id           serial       PRIMARY KEY,
  name         varchar(255) NOT NULL,
  channel      integer      NOT NULL,
  cable        boolean,
  subscription boolean
);

CREATE TABLE series (
  id         serial       PRIMARY KEY,
  station_id integer      REFERENCES stations(id) NOT NULL,
  title      varchar(255) NOT NULL,
  created_at timestamp with time zone default now()
);

CREATE TABLE episodes (
  id                serial       PRIMARY KEY,
  series_id         integer      REFERENCES series(id) NOT NULL,
  tmsid             varchar(255) NOT NULL,
  start_time        timestamp with time zone NOT NULL,
  short_start       varchar(127),
  short_end         varchar(127),
  length            integer      NOT NULL,
  title             varchar(255) NOT NULL,
  description       varchar(1023),
  season_number     integer,
  episode_number    integer,
  original_air_date varchar(127),
  created_at        timestamp with time zone default now()
);

CREATE TABLE viewers (
  id   serial       PRIMARY KEY,
  name varchar(127) NOT NULL,
  created_at timestamp with time zone default now()
  -- other attributes possible, like favorite genres
  --   or password information for login, but unnecesary
  --   for our MVPrototype
);

CREATE TABLE recordings (
  id                  serial  PRIMARY KEY,
  episode_id          integer REFERENCES episodes(id) NOT NULL,
  viewer_id           integer REFERENCES viewers(id) NOT NULL,
  play_head           integer NOT NULL, -- place in recording in seconds
  currently_recording boolean,
  created_at          timestamp with time zone default now()
);

--
-- Bonus...
--

-- DROP TABLE IF EXISTS series_viewers; -- a viewer's series
-- CREATE TABLE series_viewers (
--   -- id           serial       PRIMARY KEY, -- not using this in our join table...
--   viewer_id integer REFERENCES viewers(id) NOT NULL,
--   series_id integer REFERENCES series(id) NOT NULL
-- );

-- DROP TABLE IF EXISTS genres;
-- DROP TABLE IF EXISTS genres_series;
-- CREATE TABLE genres (
--   id   serial       PRIMARY KEY,
--   name varchar(127) NOT NULL
-- );
-- CREATE TABLE genres_series (
--   id        serial  PRIMARY KEY, -- not using this in our join table...
--   series_id integer NOT NULL,
--   genre_id  integer NOT NULL
-- );
--
-- DROP TABLE IF EXISTS flags;
-- DROP TABLE IF EXISTS flags_episodes;
-- CREATE TABLE flags (
--   id   serial       PRIMARY KEY,
--   name varchar(127) NOT NULL
-- );
-- CREATE TABLE flags_episodes (
--   id        serial  PRIMARY KEY, -- not using this in our join table...
--   episode_id integer NOT NULL,
--   series_id  integer NOT NULL
-- );
-- DROP TABLE IF EXISTS dvrs;
-- DROP TABLE IF EXISTS dvrs_viewers;
-- DROP TABLE IF EXISTS dvrs_recordings;

-- CREATE TABLE dvrs (
--   id              serial  PRIMARY KEY, -- not using this in our join table...
--   serial_number   integer NOT NULL,
--   hard_drive_size integer NOT NULL,
--   zip_code        varchar(5) NOT NULL
-- );

-- CREATE TABLE dvrs_viewers (
--   dvr_id    integer REFERENCES dvrs(id),
--   viewer_id integer REFERENCES viewers(id)
-- );

-- CREATE TABLE dvrs_recordings (
--   dvr_id        integer REFERENCES dvrs(id),
--   recordings_id integer REFERENCES recordings(id)
-- );
