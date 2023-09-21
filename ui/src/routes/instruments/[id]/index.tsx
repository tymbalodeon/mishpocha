import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";
import { type Instrument } from "../../../schema";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");
  const id = requestEvent.params.id;

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/instruments/${id}`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const instrument = useGetApiData().value as Instrument;

  return (
    <>
      {instrument ? (
        <DatabaseObject databaseObject={instrument} />
      ) : (
        <p>not found</p>
      )}
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Instrument",
  meta: [
    {
      name: "Mishpocha Database | Instrument",
      content: "Mishpocha Database | Instrument",
    },
  ],
};
