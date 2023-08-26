CREATE MIGRATION m1j6j2mkemtt2mhok22o5a2yvi7vhxa5wx4wqx4zfysdfdpzhy5wwa
    ONTO m1u5szl6osiafhojctrpbcntjo7nufvw4siw4wqk7vkffeqwcy567a
{
  ALTER TYPE default::Album {
      CREATE MULTI LINK tracks := (.discs.tracks);
  };
};
