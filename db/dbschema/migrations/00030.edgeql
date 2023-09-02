CREATE MIGRATION m12rpfutchzpzk4qnvyp2g7xysncp55y7oeoqksctaarda3z7qq3la
    ONTO m1pxqzhiefrfwyxrqk2zcbpbt4gxjmew6w6q2cwn4346ss5wpct3ta
{
  ALTER TYPE default::Date {
      ALTER PROPERTY display {
          USING ({<std::str>.local_date});
      };
  };
};
