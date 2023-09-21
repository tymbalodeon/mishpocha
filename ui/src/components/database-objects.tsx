import { component$ } from "@builder.io/qwik";
import { MishpochaObject } from "~/schema";
import { DatabaseObject, filterKeys } from "./database-object";

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
    <>
      <h3 class="font-bold text-xl pl-4 py-8">{props.title}</h3>
      <div class="w-screen sticky">
        <div class="overflow-x-auto">
          <table class="table table-pin-rows">
            <thead>
              <tr>
                {keys.map((key) => (
                  <th key={key}>{key}</th>
                ))}
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
    </>
  );
});
