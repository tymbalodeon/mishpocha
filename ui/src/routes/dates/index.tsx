import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObjects } from "../../components/database-objects";
import { MishpochaObject } from "../../schema";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/dates`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const dates = useGetApiData().value as MishpochaObject[];
  const includedKeys = ["display", "births", "deaths"];

  return (
    <DatabaseObjects
      title="Dates"
      objects={dates}
      includedKeys={includedKeys}
    />
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Dates",
  meta: [
    {
      name: "Mishpocha Database | Dates",
      content: "Mishpocha Database | Dates",
    },
  ],
};
