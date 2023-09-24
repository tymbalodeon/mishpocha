import { component$ } from "@builder.io/qwik";
import type { MishpochaObject, Player } from "../schema";

function getBaseUrl(typeName: string): string {
  if (!typeName) {
    return "";
  } else if (typeName === "person" || typeName.includes("player")) {
    return "/people";
  } else if (typeName === "series") {
    return "/series";
  } else {
    return `/${typeName}s`;
  }
}

function getBoldItem(value: string) {
  return <span class="font-bold">{value}</span>;
}

export function removeUnderscores(text: string): string {
  return text.replace("_", " ");
}

const getDisplayableValue = (
  mishpochaObject: MishpochaObject,
  key: string,
  typeName?: string,
  nested?: boolean
) => {
  let value: object | string = nested
    ? mishpochaObject
    : mishpochaObject[key as unknown as keyof typeof mishpochaObject];

  if (!(value instanceof Object)) {
    if (!(typeof value === "string")) {
      value = String(value);
      return getBoldItem(value);
    }

    const baseUrl = getBaseUrl(mishpochaObject.type_name);
    const url = `${baseUrl}/${mishpochaObject.id}`;

    return (
      <a href={url} class="link">
        {getBoldItem(value)}
      </a>
    );
  }

  if (value instanceof Array) {
    if (!value.length) {
      return getBoldItem("null");
    }

    return (
      <ul>
        {value.map((item) =>
          getDisplayableValue(
            item,
            "display",
            (item as MishpochaObject).type_name || key,
            true
          )
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

export function filterKeys(
  keys: string[],
  includedKeys?: string[],
  compact?: boolean
): string[] {
  const excludedKeys = ["id", "type_name"];

  if (!compact) {
    excludedKeys.push("display");
  }

  const filteredKeys = keys.filter((key) => !excludedKeys.includes(key));

  if (!includedKeys || !includedKeys.length) {
    return filteredKeys;
  }

  return filteredKeys.filter((key) => includedKeys.includes(key));
}

interface DatabaseProps {
  databaseObject: MishpochaObject;
  includedKeys?: string[];
  compact?: boolean;
}

export const DatabaseObject = component$<DatabaseProps>((props) => {
  const databaseObject = props.databaseObject;
  const compact = props.compact;
  const keys = filterKeys(
    Object.keys(databaseObject),
    props.includedKeys,
    compact
  );

  if (compact) {
    return (
      <tr class="hover:bg-primary hover:text-primary-content">
        {keys.map((key) => {
          const keyDisplay = removeUnderscores(key);
          const values = getDisplayableValue(databaseObject, key);
          return <td key={keyDisplay}>{values}</td>;
        })}
      </tr>
    );
  }

  return (
    <div class="card m-8">
      <div class="card-body">
        <span class="card-title font-bold text-3xl">
          {databaseObject.display}
        </span>
        <table class="table max-w-fit">
          <thead>
            <tr class="bg-base-200 text-base-content">
              <th class="capitalize text-lg">Property</th>
              <th class="capitalize text-lg">Value</th>
            </tr>
          </thead>
          <tbody>
            {keys.map((key) => {
              const keyDisplay = removeUnderscores(key);
              const values = getDisplayableValue(databaseObject, key);
              return (
                <tr key={keyDisplay}>
                  <td class="capitalize font-bold italic bg-secondary text-secondary-content w-10">
                    {keyDisplay}
                  </td>
                  <td class="bg-primary text-primary-content">{values}</td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  );
});
