import { component$ } from "@builder.io/qwik";
import { Person as PersonObject } from "../../schema.ts";

export const Person = component$<PersonObject>((props) => {
  const person = props.data;

  const data = (
    <div class="card bg-neutral shadow-xl m-4">
      <div class="card-body">
        <h2 class="card-title">{person.full_name}</h2>
        {!person.compact ? (
          <>
            <p>ID: {person.id}</p>
            <p>First name: {person.first_name}</p>
            <p>Last name: {person.last_name}</p>
            <p>Aliases: {person.aliases}</p>
            <p>
              Birth date:{" "}
              <a href={"/dates/" + person.birth_date?.display} class="link">
                <span class="font-bold">{person.birth_date?.display}</span>
              </a>
            </p>
            <p>
              Death date:{" "}
              <a href={"/dates/" + person.death_date?.display} class="link">
                {person.death_date?.display}
              </a>
            </p>
            <p>Is alive: {person.is_alive.toString()}</p>
            <p>Full name: {person.full_name}</p>
            <p>
              Age: <span class="font-bold">{person.age}</span>
            </p>
            <p>Compositions:</p>
            <ul>
              {person.compositions.map((composition, index) => (
                <li key={index}>
                  <a href={"/compositions/" + composition.title} class="link">
                    {composition.title}
                  </a>
                </li>
              ))}
            </ul>
            <p>Arrangements: {person.arrangements}</p>
            <p>Lyrics: {person.lyrics}</p>
            <p>Tracks:</p>
            <ul>
              {person.tracks.map((track, index) => (
                <li key={index}>
                  <a href={"/tracks/" + track.title} class="link">
                    {track.title}
                  </a>
                </li>
              ))}
            </ul>
            <p>Is composer: {person.is_composer.toString()}</p>
            <p>Is arranger: {person.is_arranger.toString()}</p>
            <p>Is lyricist: {person.is_lyricist.toString()}</p>
            <p>Is player: {person.is_player.toString()}</p>
            <p>Is producer: {person.is_producer.toString()}</p>
            <p>instruments: </p>
            <ul>
              {person.instruments.map((instrument, index) => (
                <li key={index}>
                  <a href={"/instruments/" + instrument.name} class="link">
                    {" "}
                    <span class="font-bold">{instrument.name}</span>
                  </a>
                </li>
              ))}
            </ul>
            <p>groups: {person.groups.map((group) => group.name)}</p>
          </>
        ) : null}
      </div>
    </div>
  );

  if (!person.compact) {
    return data;
  }

  return <a href={"/people/" + person.full_name}>{data}</a>;
});
