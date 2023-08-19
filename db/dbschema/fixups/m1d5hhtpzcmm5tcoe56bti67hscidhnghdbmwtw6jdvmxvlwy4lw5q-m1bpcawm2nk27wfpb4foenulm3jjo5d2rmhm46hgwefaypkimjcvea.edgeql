CREATE MIGRATION m1d6jheqchsfa2ltjuwj4djuq2ew6euys7tghicpywxvubofuiexqa
    ONTO m1d5hhtpzcmm5tcoe56bti67hscidhnghdbmwtw6jdvmxvlwy4lw5q
{
  ALTER TYPE default::Person {
      CREATE PROPERTY is_arranger := (WITH
          id := 
              .id
      SELECT
          (std::count(default::Composition FILTER
              (.arrangers.id = id)
          ) > 0)
      );
      CREATE PROPERTY is_lyricist := (WITH
          id := 
              .id
      SELECT
          (std::count(default::Composition FILTER
              (.lyricists.id = id)
          ) > 0)
      );
  };
};
