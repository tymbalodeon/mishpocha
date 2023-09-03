import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/tracks`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const tracks = useGetApiData().value;

  return (
    <>
      <h2 class="font-bold text-xl pl-4 pt-8">Tracks</h2>
      {tracks
        ? tracks.map((track, index) => {
            track.compact = true;
            return <DatabaseObject key={index} data={track} />;
          })
        : null}
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Tracks",
  meta: [
    {
      name: "Mishpocha Database | Tracks",
      content: "Mishpocha Database | Tracks",
    },
  ],
};
