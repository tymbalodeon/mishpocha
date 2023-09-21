import { component$ } from "@builder.io/qwik";
import { MishpochaObject } from "~/schema";
import { DatabaseObject, filterKeys } from "./database-object";

interface DatabaseObjectsProps {
  title: string;
  objects: MishpochaObject[];
}

function getKeys(objects: MishpochaObject[]): string[] {
  if (!objects.length) {
    return [];
  }

  return filterKeys(Object.keys(objects[0]));
}

export const DatabaseObjects = component$<DatabaseObjectsProps>((props) => {
  const databaseObjects = props.objects;
  const keys = getKeys(databaseObjects);

  return (
    <>
      <h3 class="font-bold text-xl pl-4 py-8">{props.title}</h3>
      <div class="w-screen sticky">
        <div class="overflow-x-auto">
          <table class="table table-pin-rows">
            <thead>
              <tr>
                {keys.map((key) => (
                  <th>{key}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {databaseObjects
                ? databaseObjects.map((databaseObject: MishpochaObject) => {
                    return (
                      <DatabaseObject
                        key={databaseObject.id}
                        data={databaseObject}
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
