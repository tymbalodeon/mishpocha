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
    const response = await fetch(`${apiDomain}/labels`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const labels = useGetApiData().value as MishpochaObject[];
  const includedKeys = ["name", "series"];

  return (
    <DatabaseObjects
      title="Labels"
      objects={labels}
      includedKeys={includedKeys}
    />
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Labels",
  meta: [
    {
      name: "Mishpocha Database | Labels",
      content: "Mishpocha Database | Labels",
    },
  ],
};
