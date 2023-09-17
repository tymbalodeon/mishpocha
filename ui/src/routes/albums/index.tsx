import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/albums`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const albums = useGetApiData().value;
  const keys = Object.keys(albums[0]);

  return (
    <>
      <h3 class="font-bold text-xl pl-4 pt-8">Albums</h3>
      <div class="overflow-x-auto">
        <table class="table table-zebra">
          <thead>
            <tr>
              {keys.map((key, index) => {
                key = key.replace("_", " ");

                return <th key={index}>{key}</th>;
              })}
            </tr>
          </thead>
          <tbody>
            {albums
              ? albums.map((album, index) => {
                  album.compact = true;
                  return <DatabaseObject key={index} data={album} />;
                })
              : null}
          </tbody>
        </table>
      </div>
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Albums",
  meta: [
    {
      name: "Mishpocha Database | Albums",
      content: "Mishpocha Database | Albums",
    },
  ],
};
