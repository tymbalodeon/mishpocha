CREATE MIGRATION m1ohnxsjmhokrrvppm7hhvbrhpq2iyurj35kd6jxxbzdsgx5vhnsnq
    ONTO m1pt5r6uo4b3qge2nusaxtim4aebtxxx253yz5ortmji5fgstugv5q
{
  ALTER TYPE default::Album {
      CREATE PROPERTY duration := (std::to_duration(seconds := std::sum(std::duration_get(.discs.duration, 'totalseconds'))));
  };
};
