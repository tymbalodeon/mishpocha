CREATE MIGRATION m1pt5r6uo4b3qge2nusaxtim4aebtxxx253yz5ortmji5fgstugv5q
    ONTO m1kyla6bshf2j2bgjzj7pwp5r4jabuxfcqz4564o7xgomvhqgmjpma
{
  ALTER TYPE default::Disc {
      CREATE PROPERTY duration := (std::to_duration(seconds := std::sum(std::duration_get(.tracks.duration, 'totalseconds'))));
  };
};
