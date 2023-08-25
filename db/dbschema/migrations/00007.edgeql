CREATE MIGRATION m1vhbdwhvgnmdvrnwyn3xi7y2nfdbazpipq3rw72sragak4c57dwqq
    ONTO m1z65ji3nbri7anexkfqfuacyendxtpfckn432cg5744va4p2fzrvq
{
  ALTER TYPE default::Label {
      ALTER LINK artists {
          USING (.albums.artists);
      };
  };
};
