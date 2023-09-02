import { component$ } from "@builder.io/qwik";
import { Person as PersonObject } from "../../schema.ts";

export const Person = component$<PersonObject>((props) => {
  const person = props.data;

  const data = (
    <div class="card w-96 bg-neutral shadow-xl m-4">
      <div class="card-body">
        <h2 class="card-title">{person.full_name}</h2>
        {!person.compact ? (
          <>
            <p>ID: {person.id}</p>
            <p>First name: {person.first_name}</p>
            <p>Last name: {person.last_name}</p>
            <p>Aliases: {person.aliases}</p>
            <p>Birth date: {person.birth_date?.display}</p>
            <p>Death date: {person.death_date?.display}</p>
            <p>Is alive: {person.is_alive.toString()}</p>
            <p>Full name: {person.full_name}</p>
            <p>Age: {person.age}</p>
            <p>
              Compositions:{" "}
              {person.compositions.map((composition) => composition.title)}
            </p>
            <p>Arrangements: {person.arrangements}</p>
            <p>Lyrics: {person.lyrics}</p>
            <p>Tracks: {person.tracks.map((track) => track.title)}</p>
            <p>Is composer: {person.is_composer.toString()}</p>
            <p>Is arranger: {person.is_arranger.toString()}</p>
            <p>Is lyricist: {person.is_lyricist.toString()}</p>
            <p>Is player: {person.is_player.toString()}</p>
            <p>Is producer: {person.is_producer.toString()}</p>
            <p>
              instruments:{" "}
              {person.instruments.map((instrument) => instrument.name)}
            </p>
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
