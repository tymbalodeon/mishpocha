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

  return (
    <>
      <h2 class="font-bold text-xl pl-4 pt-8">Albums</h2>
      {albums
        ? albums.map((album, index) => {
            album.compact = true;
            return <DatabaseObject key={index} data={album} />;
          })
        : null}
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