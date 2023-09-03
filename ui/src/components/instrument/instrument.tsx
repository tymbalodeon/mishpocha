import { component$ } from "@builder.io/qwik";
import { Instrument as InstrumentObject } from "../../schema.ts";

export const Instrument = component$<InstrumentObject>((props) => {
  const instrument = props.data;

  const data = (
    <div class="card bg-neutral shadow-xl m-4">
      <div class="card-body">
        <h2 class="card-title">{instrument.name}</h2>
        {!instrument.compact ? (
          <>
            <p>ID: {instrument.id}</p>
            <p>Name: {instrument.name}</p>
            <p>Aliases: {instrument.aliases}</p>
            <p>Tuning: {instrument.tuning}</p>
            <p>
              Players:{" "}
              {instrument.players.map((player, index) => (
                <a
                  key={index}
                  href={"/people/" + player.person?.full_name}
                  class="link"
                >
                  {player.person?.full_name}
                </a>
              ))}
            </p>
          </>
        ) : null}
      </div>
    </div>
  );

  if (!instrument.compact) {
    return data;
  }

  return <a href={"/instruments/" + instrument.name}>{data}</a>;
});
