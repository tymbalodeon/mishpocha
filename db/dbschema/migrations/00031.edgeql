CREATE MIGRATION m16ajm5c3xpwo46p6j7qptxtvr72trd6pwyr7cf2mnumeeondexpiq
    ONTO m12rpfutchzpzk4qnvyp2g7xysncp55y7oeoqksctaarda3z7qq3la
{
  CREATE ABSTRACT PROPERTY default::type_name {
      SET readonly := true;
  };
  ALTER TYPE default::Date {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'date';
      };
  };
};
