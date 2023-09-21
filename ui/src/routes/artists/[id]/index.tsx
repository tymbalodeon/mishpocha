import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";
import { type Artist } from "../../../schema";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");
  const id = requestEvent.params.id;

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/artists/${id}`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const artist = useGetApiData().value as Artist;

  return (
    <>
      {artist ? <DatabaseObject databaseObject={artist} /> : <p>not found</p>}
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Artist",
  meta: [
    {
      name: "Mishpocha Database | Artist",
      content: "Mishpocha Database | Artist",
    },
  ],
};
