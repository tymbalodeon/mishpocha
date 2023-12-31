import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";
import { type Date } from "../../../schema";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");
  const id = requestEvent.params.id;

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/dates/${id}`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const date = useGetApiData().value as Date;

  return (
    <>{date ? <DatabaseObject databaseObject={date} /> : <p>not found</p>}</>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Date",
  meta: [
    {
      name: "Mishpocha Database | Date",
      content: "Mishpocha Database | Date",
    },
  ],
};
