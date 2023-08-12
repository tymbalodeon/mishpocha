CREATE MIGRATION m1wp5y6f2gr3r2jzm4al4gq73jtfd4uynbwx4mj6udy4zct2wiht4q
    ONTO m15gstjtv2gnbxaqvv7f2xvthhpqvtlyj7kgqyftty4lhumrc6d25a
{
  CREATE TYPE default::Series {
      CREATE LINK label: default::Label;
      CREATE PROPERTY name: std::str;
  };
  ALTER TYPE default::Label {
      CREATE MULTI LINK series := (.<label[IS default::Series]);
  };
};
