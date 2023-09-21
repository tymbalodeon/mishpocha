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
    const response = await fetch(`${apiDomain}/people`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const people = useGetApiData().value as MishpochaObject[];
  const includedKeys = ["full_name", "age"];

  return (
    <DatabaseObjects
      title="People"
      objects={people}
      includedKeys={includedKeys}
    />
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | People",
  meta: [
    {
      name: "Mishpocha Database | People",
      content: "Mishpocha Database | People",
    },
  ],
};
