import { component$ } from "@builder.io/qwik";
import type { DatabaseProps } from "../../schema.ts";

const getBaseUrl = (typeName) => {
  if (typeName == "person") {
    return "/people";
  } else if (typeName == "series") {
    return "/series";
  } else if (typeName == "player") {
    return "/people";
  } else {
    return `/${typeName}s`;
  }
};

const getDisplayableValue = (object, key, typeName) => {
  let value = object instanceof Object ? object[key] : object;

  if (!(value instanceof Object)) {
    if (!typeName) {
      if (!(value instanceof String)) {
        value = String(value);
      }

      return <span class="font-bold">{value}</span>;
    }

    let baseUrl;

    if (typeName == "players") {
      value = object.person.display;
      baseUrl = "/people";
    } else {
      baseUrl = getBaseUrl(typeName);
    }

    return (
      <li>
        <a href={`${baseUrl}/${value}`} class="link font-bold">
          {value}
        </a>
      </li>
    );
  }

  if (value instanceof Array) {
    if (!value.length) {
      return <span class="font-bold">null</span>;
    }

    return (
      <ul>
        {value.map((item) =>
          getDisplayableValue(item, "display", item.type_name || key),
        )}
      </ul>
    );
  }

  return <span class="font-bold">{value.display}</span>;
};

export const DatabaseObject = component$<DatabaseProps>((props) => {
  const object = props.data;
  const keys = Object.keys(object);

  const data = (
    <div class="card bg-neutral shadow-xl m-4">
      <div class="card-body">
        <h2 class="card-title">{object.display}</h2>
        {!object.compact ? (
          <>
            {keys.map((key, index) => (
              <div key={index}>
                {key.replace("_", " ")}: {getDisplayableValue(object, key)}
              </div>
            ))}
          </>
        ) : null}
      </div>
    </div>
  );

  if (!object.compact) {
    return data;
  }

  const baseUrl = getBaseUrl(object.type_name);

  return <a href={`${baseUrl}/${object.display}`}>{data}</a>;
});
