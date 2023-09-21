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
    const response = await fetch(`${apiDomain}/series`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const series = useGetApiData().value as MishpochaObject[];
  const includedKeys = ["name", "label"];

  return (
    <DatabaseObjects
      title="Series"
      objects={series}
      includedKeys={includedKeys}
    />
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Series",
  meta: [
    {
      name: "Mishpocha Database | Series",
      content: "Mishpocha Database | Series",
    },
  ],
};
