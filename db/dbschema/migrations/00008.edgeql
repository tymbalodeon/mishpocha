CREATE MIGRATION m1kyla6bshf2j2bgjzj7pwp5r4jabuxfcqz4564o7xgomvhqgmjpma
    ONTO m1ca6bk43oxivgwm3agd24qcgur3vniz7yamwwowekeiyn7cmywbgq
{
  ALTER TYPE default::Person {
      CREATE PROPERTY is_producer := ((std::count(.<producers[IS default::Album]) > 0));
  };
};
