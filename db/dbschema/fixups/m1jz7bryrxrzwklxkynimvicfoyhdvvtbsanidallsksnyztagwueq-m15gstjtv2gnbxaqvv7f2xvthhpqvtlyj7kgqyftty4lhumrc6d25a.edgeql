CREATE MIGRATION m1iiuqrf7qwgnzp7k2vyihvyvhb54gouc6wlk53libojr24ho7ae5a
    ONTO m1jz7bryrxrzwklxkynimvicfoyhdvvtbsanidallsksnyztagwueq
{
  ALTER TYPE default::Label {
      ALTER LINK artists {
          USING (WITH
              albums := 
                  .albums
              ,
              albums := 
                  (SELECT
                      default::Album
                  FILTER
                      (default::Album IN albums)
                  )
          SELECT
              albums.artists
          );
      };
  };
};
