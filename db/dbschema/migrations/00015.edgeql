CREATE MIGRATION m1jjl5lb4cawfbv3pz5sthkykzk57fjtetrlmdgtxzscm66q4bnoaq
    ONTO m1j6j2mkemtt2mhok22o5a2yvi7vhxa5wx4wqx4zfysdfdpzhy5wwa
{
  ALTER TYPE default::Player {
      CREATE PROPERTY display := ((((.person.full_name ++ ' (') ++ .instrument.name) ++ ')'));
  };
};
