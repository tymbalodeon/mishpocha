CREATE MIGRATION m1qmlm4pkjj3szb2olt4comxyi6ghsl4qwogsrhffkc2ikfcsayrra
    ONTO m17ghc26duvra3p72izqi3xmod6udjzgym4kyyllfltgpgs2zkzqfa
{
  ALTER TYPE default::Person {
      CREATE PROPERTY is_player := (WITH
          id := 
              .id
      SELECT
          (std::count(default::Player FILTER
              (.person.id = id)
          ) > 0)
      );
  };
};
