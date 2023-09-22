import { component$ } from "@builder.io/qwik";
import { MishpochaObject } from "~/schema";
import {
  DatabaseObject,
  filterKeys,
  removeUnderscores,
} from "./database-object";

interface DatabaseObjectsProps {
  title: string;
  objects: MishpochaObject[];
  includedKeys: string[];
}

export const DatabaseObjects = component$<DatabaseObjectsProps>((props) => {
  const databaseObjects = props.objects;
  const includedKeys = props.includedKeys;
  const keys = [];

  if (databaseObjects.length) {
    keys.push(...filterKeys(Object.keys(databaseObjects[0]), includedKeys));
  }

  return (
    <div class="card m-8">
      <div class="card-body">
        <span class="card-title font-bold text-3xl">{props.title}</span>
        <table class="table overflow-x-auto table-pin-rows bg-neutral text-neutral-content">
          <thead>
            <tr class="bg-base-200 text-base-content">
              {keys.map((key) => {
                const keyDisplay = removeUnderscores(key);
                return (
                  <th key={key} class="capitalize text-lg">
                    {keyDisplay}
                  </th>
                );
              })}
            </tr>
          </thead>
          <tbody>
            {databaseObjects
              ? databaseObjects.map((databaseObject: MishpochaObject) => {
                  return (
                    <DatabaseObject
                      key={databaseObject.id}
                      databaseObject={databaseObject}
                      includedKeys={includedKeys}
                      compact={true}
                    />
                  );
                })
              : null}
          </tbody>
        </table>
      </div>
    </div>
  );
});
