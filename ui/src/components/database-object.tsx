import { component$ } from "@builder.io/qwik";
import type { DatabaseProps } from "../../schema.ts";

const getBaseUrl = (typeName) => {
  if (!typeName) {
    return "";
  } else if (typeName == "person" || typeName.includes("player")) {
    return "/people";
  } else if (typeName == "series") {
    return "/series";
  } else {
    return `/${typeName}s`;
  }
};

const getDisplayableValue = (object, key, typeName, nested) => {
  let value = nested ? object : object[key];

  if (!(value instanceof Object)) {
    if (!(typeof value == "string")) {
      value = String(value);
    }

    return <span class="font-bold">{value}</span>;
  }

  if (value instanceof Array) {
    if (!value.length) {
      return <span class="font-bold">null</span>;
    }

    return (
      <ul>
        {value.map((item) =>
          getDisplayableValue(item, "display", item.type_name || key, true),
        )}
      </ul>
    );
  }

  if (typeName == "players") {
    value = value.person;
  }

  const baseUrl = getBaseUrl(typeName || value.type_name);
  const link = (
    <a href={`${baseUrl}/${value.id}`} class="link font-bold">
      {value.display}
    </a>
  );

  if (nested) {
    return <li>{link}</li>;
  }

  return link;
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
            {keys.map((key, index) => {
              key = key.replace("_", " ");
              const values = getDisplayableValue(object, key);

              if (values.type == "ul" && key != "age") {
                return (
                  <div key={index} class="collapse collapse-arrow bg-base-200">
                    <input type="checkbox" />
                    <div class="collapse-title text-xl font-medium">{key}</div>
                    <div class="collapse-content">{values}</div>
                  </div>
                );
              }

              return (
                <div key={index}>
                  {key}: {values}
                </div>
              );
            })}
          </>
        ) : null}
      </div>
    </div>
  );

  if (!object.compact) {
    return data;
  }

  const baseUrl = getBaseUrl(object.type_name);

  return <a href={`${baseUrl}/${object.id}`}>{data}</a>;
});
