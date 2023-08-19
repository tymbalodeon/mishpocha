CREATE MIGRATION m14vqs7cftq7ufyxewo3kcnq72fyk6vlvvj77rihtuflmn2zxedosq
    ONTO m1bpcawm2nk27wfpb4foenulm3jjo5d2rmhm46hgwefaypkimjcvea
{
  ALTER TYPE default::Person {
      CREATE MULTI LINK arrangements := (.<arrangers[IS default::Composition]);
      ALTER PROPERTY is_arranger {
          USING ((std::count(.arrangements) > 0));
      };
      CREATE MULTI LINK groups := (.<members[IS default::Artist]);
      CREATE MULTI LINK lyrics := (.<lyricists[IS default::Composition]);
      ALTER PROPERTY is_lyricist {
          USING ((std::count(.lyrics) > 0));
      };
      ALTER PROPERTY is_composer {
          USING ((std::count(.compositions) > 0));
      };
      ALTER PROPERTY is_player {
          USING ((std::count(.<person[IS default::Player]) > 0));
      };
  };
};
