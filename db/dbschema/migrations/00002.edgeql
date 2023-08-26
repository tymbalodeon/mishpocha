CREATE MIGRATION m1q7e6w6nqzb2raxhriplqgd6yqe5aqtvswn4foplnmw2miojtjjxa
    ONTO m1zedttmav2ik7th7cvimucsqucoiwl7uh6i6exjfmmaohrfoisjhq
{
  ALTER TYPE default::Composition {
      ALTER LINK composers {
          ON TARGET DELETE ALLOW;
      };
  };
};
