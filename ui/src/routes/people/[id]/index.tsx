import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";
import { type Person } from "../../../schema";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");
  const id = requestEvent.params.id;

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/people/${id}`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const person = useGetApiData().value as Person;

  return (
    <>
      {person ? <DatabaseObject databaseObject={person} /> : <p>not found</p>}
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Person",
  meta: [
    {
      name: "Mishpocha Database | Person",
      content: "Mishpocha Database | Person",
    },
  ],
};
