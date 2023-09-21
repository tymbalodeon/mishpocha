import { component$ } from "@builder.io/qwik";
import type { MishpochaObject, Player } from "../schema";

const getBaseUrl = (typeName: string): string => {
  if (!typeName) {
    return "";
  } else if (typeName === "person" || typeName.includes("player")) {
    return "/people";
  } else if (typeName === "series") {
    return "/series";
  } else {
    return `/${typeName}s`;
  }
};

const getDisplayableValue = (
  mishpochaObject: MishpochaObject,
  key: string,
  typeName?: string,
  nested?: boolean,
) => {
  let value: object | string = nested
    ? mishpochaObject
    : mishpochaObject[key as unknown as keyof typeof mishpochaObject];

  if (!(value instanceof Object)) {
    if (!(typeof value === "string")) {
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
          getDisplayableValue(
            item,
            "display",
            (item as MishpochaObject).type_name || key,
            true,
          ),
        )}
      </ul>
    );
  }

  if (typeName === "players") {
    value = (value as unknown as Player).person;
  }

  const baseUrl = getBaseUrl(typeName || (value as MishpochaObject).type_name);
  const link = (
    <a
      href={`${baseUrl}/${(value as MishpochaObject).id}`}
      class="link font-bold"
    >
      {(value as MishpochaObject).display}
    </a>
  );

  if (nested) {
    return <li>{link}</li>;
  }

  return link;
};

export function filterKeys(keys: string[], includedKeys?: string[]): string[] {
  if (!includedKeys || !includedKeys.length) {
    return keys;
  }

  return keys.filter((key) => includedKeys.includes(key));
}

interface DatabaseProps {
  databaseObject: MishpochaObject;
  includedKeys?: string[];
  compact?: boolean;
}

export const DatabaseObject = component$<DatabaseProps>((props) => {
  const databaseObject = props.databaseObject;
  const keys = filterKeys(Object.keys(databaseObject), props.includedKeys);

  if (props.compact) {
    return (
      <tr class="hover">
        {keys.map((key) => {
          const keyDisplay = key.replace("_", " ");
          const values = getDisplayableValue(databaseObject, keyDisplay);

          return <td key={keyDisplay}>{values}</td>;
        })}
      </tr>
    );
  }

  return (
    <div class="card bg-neutral shadow-xl m-4">
      <div class="card-body">
        <h3 class="card-title">{databaseObject.display}</h3>
        {keys.map((key) => {
          const keyDisplay = key.replace("_", " ");
          const values = getDisplayableValue(databaseObject, keyDisplay);

          if (values.type === "ul" && !["age", "label"].includes(keyDisplay)) {
            return (
              <div
                key={keyDisplay}
                class="collapse collapse-arrow bg-base-200"
              >
                <input type="checkbox" />
                <div class="collapse-title text-xl font-medium">
                  {keyDisplay}
                </div>
                <div class="collapse-content">{values}</div>
              </div>
            );
          }

          return (
            <div key={keyDisplay}>
              {keyDisplay}: {values}
            </div>
          );
        })}
      </div>
    </div>
  );
});
