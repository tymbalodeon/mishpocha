CREATE MIGRATION m12fc3rmzr7eky2xr3fdclkfzeqvbg4ntacosljtd274dfpkzogodq
    ONTO m1yx3z2onf6jiotbyzlssit25nb2nnu4uegfb4cdix257c4jdn4uoq
{
  ALTER TYPE default::Album {
      CREATE LINK series: default::Series;
  };
};
