CREATE MIGRATION m1xetp7tbr77utlibcgz3x7dovequ4pqiwcxxzp6ugli4jfyhbrpja
    ONTO m1twkh3l62ybyh7ge4qw4znbs754l4qhu5mhdz2bdsoieb7ihzwk2a
{
  CREATE TYPE default::Label {
      CREATE PROPERTY name: std::str;
  };
  ALTER TYPE default::Album {
      CREATE LINK label: default::Label;
  };
  ALTER TYPE default::Label {
      CREATE MULTI LINK albums := (.<label[IS default::Album]);
      CREATE MULTI LINK artists := (WITH
          albums := 
              .albums
          ,
          found_albums := 
              (SELECT
                  default::Album
              FILTER
                  (default::Album IN albums)
              )
      SELECT
          found_albums.artists
      );
  };
};
