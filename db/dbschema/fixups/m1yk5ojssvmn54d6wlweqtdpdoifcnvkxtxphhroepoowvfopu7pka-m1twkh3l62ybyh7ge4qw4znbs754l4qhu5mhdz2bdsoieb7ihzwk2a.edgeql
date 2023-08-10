CREATE MIGRATION m1onkwbaqvglupbto7rz2dutz7facbvddlvi4fmfwsvvroit27xcma
    ONTO m1yk5ojssvmn54d6wlweqtdpdoifcnvkxtxphhroepoowvfopu7pka
{
  ALTER TYPE default::Date {
      CREATE MULTI LINK compositions := (.<composition_date[IS default::Composition]);
  };
  ALTER TYPE default::Person {
      CREATE MULTI LINK compositions := (.<composers[IS default::Composition]);
  };
};
