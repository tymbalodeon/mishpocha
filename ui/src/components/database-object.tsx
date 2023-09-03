import { component$ } from "@builder.io/qwik";
import { DatabaseProps } from "../../schema.ts";

const getBaseUrl = (typeName) => {
  if (typeName == "person") {
    return "/people";
  } else {
    return `/${typeName}s`;
  }
};

const getDisplayableValue = (object, key, typeName) => {
  let value = object[key];

  if (!(value instanceof Object)) {
    if (!typeName) {
      return value;
    }

    const baseUrl = getBaseUrl(typeName);

    return (
      <a href={`${baseUrl}/${value}`} class="link font-bold">
        {value}
      </a>
    );
  }

  if (value instanceof Array) {
    return value.map((item) =>
      getDisplayableValue(item, "display", item.type_name),
    );
  }
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
              <p key={index}>
                {key.replace("_", " ")}:{" "}
                <span class="font-bold">
                  {getDisplayableValue(object, key)}
                </span>
              </p>
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
