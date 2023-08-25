CREATE MIGRATION m1z65ji3nbri7anexkfqfuacyendxtpfckn432cg5744va4p2fzrvq
    ONTO m17detel35e5pqbjq6xdtipgf3xphxgv57tustn5vtfnrbfiycejka
{
  ALTER TYPE default::Person {
      ALTER LINK tracks {
          USING (.<person[IS default::Player].<players[IS default::Track]);
      };
  };
};
