CREATE MIGRATION m17frhh7xmaqin5zdl47kaf7uz2gnii6w6qctc6od6di34kmr5h3na
    ONTO m1irmcerix4jt7xxfr535hzop3g7o5kn7k53pq5ri2kjxobrha6u6q
{
  ALTER TYPE default::Album {
      CREATE MULTI LINK producers: default::Person;
  };
};
