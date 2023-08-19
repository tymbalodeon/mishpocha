CREATE MIGRATION m17dyd7t57mvg6abouraq33ojgcmqsbetan7kyriemvyw5jm2icrta
    ONTO m1wqt2tkbsdouzktuhd7dsiisrq5g2gotednptrvzmynfx5k5cgpqa
{
  ALTER TYPE default::Person {
      CREATE PROPERTY is_composer := (WITH
          id := 
              .id
      SELECT
          (std::count(default::Composition FILTER
              (.composers.id = id)
          ) > 0)
      );
  };
};
