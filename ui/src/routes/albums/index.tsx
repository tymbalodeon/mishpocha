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
    const response = await fetch(`${apiDomain}/albums`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const albums = useGetApiData().value as MishpochaObject[];
  const includedKeys = ["title", "artists", "label"];

  return (
    <DatabaseObjects
      title="Albums"
      objects={albums}
      includedKeys={includedKeys}
    />
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Albums",
  meta: [
    {
      name: "Mishpocha Database | Albums",
      content: "Mishpocha Database | Albums",
    },
  ],
};
