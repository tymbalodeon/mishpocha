import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");
  const id = requestEvent.params.id;

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/albums/${id}`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const album = useGetApiData().value;

  return <>{album ? <DatabaseObject data={album} /> : <p>not found</p>}</>;
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Album",
  meta: [
    {
      name: "Mishpocha Database | Album",
      content: "Mishpocha Database | Album",
    },
  ],
};
