import { component$ } from "@builder.io/qwik";
import { Date as DateObject } from "../../schema.ts";

export const Date = component$<DateObject>((props) => {
  const date = props.data;

  const data = (
    <div class="card bg-neutral shadow-xl m-4">
      <div class="card-body">
        <h2 class="card-title">{date.display}</h2>
        {!date.compact ? (
          <>
            <p>Day: {date.day}</p>
            <p>Month: {date.month}</p>
            <p>Year: {date.year}</p>
            <p>Display: {date.display}</p>
            <p>
              Births:{" "}
              {date.births.map((person) => (
                <a href={"/people/" + person.full_name} class="link">
                  {person.full_name}
                </a>
              ))}
            </p>
            <p>
              Deaths:{" "}
              {date.deaths.map((person) => (
                <a href={"/people/" + person.full_name} class="link">
                  {person.full_name}
                </a>
              ))}
            </p>
            <p>
              Artist start: {date.artist_starts.map((artist) => artist.name)}
            </p>
            <p>Artist end: {date.artist_ends.map((artist) => artist.name)}</p>
            <p>
              Compositions:{" "}
              {date.compositions.map((composition) => composition.title)}
            </p>
            <p>
              Arrangements:{" "}
              {date.arrangements.map((arrangement) => arrangement.title)}
            </p>
            <p>
              Tracks recorded:{" "}
              {date.tracks_recorded.map((track) => track.title)}
            </p>
            <p>
              Tracks released:{" "}
              {date.tracks_released.map((track) => track.title)}
            </p>
            <p>
              Tracks mastered:{" "}
              {date.tracks_mastered.map((track) => track.title)}
            </p>
            <p>Tracks mixed: {date.tracks_mixed.map((track) => track.title)}</p>
            <p>
              Albums released:{" "}
              {date.albums_released.map((album) => album.title)}
            </p>
          </>
        ) : null}
      </div>
    </div>
  );

  if (!date.compact) {
    return data;
  }

  return <a href={"/dates/" + date.display}>{data}</a>;
});
