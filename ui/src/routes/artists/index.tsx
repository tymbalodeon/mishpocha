import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/artists`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const artists = useGetApiData().value;

  return (
    <>
      <h2 class="font-bold text-xl pl-4 pt-8">Artists</h2>
      {artists
        ? artists.map((artist, index) => {
            artist.compact = true;
            return <DatabaseObject key={index} data={artist} />;
          })
        : null}
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Artists",
  meta: [
    {
      name: "Mishpocha Database | Artists",
      content: "Mishpocha Database | Artists",
    },
  ],
};