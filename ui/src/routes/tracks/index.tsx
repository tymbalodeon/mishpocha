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
    const response = await fetch(`${apiDomain}/tracks`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const tracks = useGetApiData().value as MishpochaObject[];
  const includedKeys = ["title", "players"];

  return (
    <DatabaseObjects
      title="Tracks"
      objects={tracks}
      includedKeys={includedKeys}
    />
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Tracks",
  meta: [
    {
      name: "Mishpocha Database | Tracks",
      content: "Mishpocha Database | Tracks",
    },
  ],
};
