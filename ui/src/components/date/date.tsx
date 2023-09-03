import { component$ } from "@builder.io/qwik";
import { Date as DateObject } from "../../schema.ts";

const getDisplayableValue = (object, key, typeName) => {
  let value = object[key];

  if (!(value instanceof Object)) {
    if (!typeName) {
      return value;
    }

    let baseUrl: string;

    if (typeName == "person") {
      baseUrl = "/people";
    } else {
      baseUrl = `/${typeName}s/`;
    }

    return (
      <a href={`${baseUrl}/${value}`} class="link">
        {value}
      </a>
    );
  }

  if (value instanceof Array) {
    return value.map((item) =>
      getDisplayableValue(item, "display", item.type_name),
    );
  }

  let display = value.display;

  if (!display) {
    display = value.full_name;
  }

  return display;
};

export const Date = component$<DateObject>((props) => {
  const object = props.data;
  const keys = Object.keys(object);

  const data = (
    <div class="card bg-neutral shadow-xl m-4">
      <div class="card-body">
        <h2 class="card-title">{object.display}</h2>
        {!object.compact ? (
          <>
            {keys.map((key, index) => (
              <p key={index}>
                {key.replace("_", " ")}:{" "}
                <span class="font-bold">
                  {getDisplayableValue(object, key)}
                </span>
              </p>
            ))}
            {/* <p>
                Day: <span class="font-bold">{object.day}</span>
                </p>
                <p>
                Month: <span class="font-bold">{object.month}</span>
                </p>
                <p>
                Year: <span class="font-bold">{object.year}</span>
                </p>
                <p>
                Display: <span class="font-bold">{object.display}</span>
                </p>
                <p>
                Births:{" "}
                {object.births.map((person, index) => (
                <a
                key={index}
                href={"/people/" + person.full_name}
                class="link"
                >
                <span class="font-bold">{person.full_name}</span>
                </a>
                ))}
                </p>
                <p>
                Deaths:{" "}
                {object.deaths.map((person, index) => (
                <a
                key={index}
                href={"/people/" + person.full_name}
                class="link"
                >
                {person.full_name}
                </a>
                ))}
                </p>
                <p>
                Artist start: {object.artist_starts.map((artist) => artist.name)}
                </p>
                <p>Artist end: {object.artist_ends.map((artist) => artist.name)}</p>
                <p>Compositions: </p>
                <ul>
                {object.compositions.map((composition, index) => (
                <li key={index}>
                <a href={"/compositions/" + composition.title} class="link">
                <span class="font-bold">{composition.title}</span>
                </a>
                </li>
                ))}
                </ul>
                <p>
                Arrangements:{" "}
                {object.arrangements.map((arrangement) => arrangement.title)}
                </p>
                <p>Tracks recorded: </p>
                <ul>
                {object.tracks_recorded.map((track, index) => (
                <li key={index}>
                <a href={"/compositions/" + track.title} class="link">
                <span class="font-bold">{track.title}</span>
                </a>
                </li>
                ))}
                </ul>
                <p>
                Tracks released:{" "}
                {object.tracks_released.map((track) => track.title)}
                </p>
                <p>
                Tracks mastered:{" "}
                {object.tracks_mastered.map((track) => track.title)}
                </p>
                <p>
                Tracks mixed: {object.tracks_mixed.map((track) => track.title)}
                </p>
                <p>
                Albums released:{" "}
                {object.albums_released.map((album) => album.title)}
                </p> */}
          </>
        ) : null}
      </div>
    </div>
  );

  if (!object.compact) {
    return data;
  }

  return <a href={"/dates/" + object.display}>{data}</a>;
});
