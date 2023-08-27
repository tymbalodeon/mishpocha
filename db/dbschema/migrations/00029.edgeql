CREATE MIGRATION m1pxqzhiefrfwyxrqk2zcbpbt4gxjmew6w6q2cwn4346ss5wpct3ta
    ONTO m1uj2vxosht2mnmav5rp2zihf3hxnhlakni4z2xpcgjzh65v6cbpya
{
  ALTER TYPE default::Label {
      ALTER LINK series {
          RESET EXPRESSION;
          RESET EXPRESSION;
          RESET OPTIONALITY;
          SET TYPE default::Series;
      };
  };
  ALTER TYPE default::Series {
      ALTER LINK label {
          USING (.<series[IS default::Label]);
      };
      CREATE MULTI LINK albums := (.<series[IS default::Album]);
  };
};
