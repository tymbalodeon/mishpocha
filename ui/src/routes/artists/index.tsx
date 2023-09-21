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
    const response = await fetch(`${apiDomain}/artists`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const artists = useGetApiData().value as MishpochaObject[];
  const includedKeys = ["name", "members"];

  return (
    <DatabaseObjects
      title="Artists"
      objects={artists}
      includedKeys={includedKeys}
    />
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Artists",
  meta: [
    {
      name: "Mishpocha Database | Artists",
      content: "Mishpocha Database | Artists",
    },
  ],
};
