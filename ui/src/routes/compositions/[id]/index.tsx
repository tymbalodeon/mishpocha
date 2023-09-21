import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";
import { type Composition } from "../../../schema";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");
  const id = requestEvent.params.id;

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/compositions/${id}`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const composition = useGetApiData().value as Composition;

  return (
    <>
      {composition ? <DatabaseObject data={composition} /> : <p>not found</p>}
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Composition",
  meta: [
    {
      name: "Mishpocha Database | Composition",
      content: "Mishpocha Database | Composition",
    },
  ],
};
