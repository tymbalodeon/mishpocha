CREATE MIGRATION m1cdyu6s2sqdsadow7u6pdwioctp3a7lqpzyarxpjtrr4c4rnqnc5a
    ONTO m1ohnxsjmhokrrvppm7hhvbrhpq2iyurj35kd6jxxbzdsgx5vhnsnq
{
  ALTER TYPE default::Disc {
      CREATE LINK album: default::Album;
      CREATE PROPERTY disc_title: std::str;
      ALTER PROPERTY title {
          USING ({(.disc_title ?? .album.title)});
      };
  };
};
