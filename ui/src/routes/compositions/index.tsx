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
    const response = await fetch(`${apiDomain}/compositions`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const compositions = useGetApiData().value as MishpochaObject[];

  return <DatabaseObjects objects={compositions} title="Compositions" />;
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Compositions",
  meta: [
    {
      name: "Mishpocha Database | Compositions",

      content: "Mishpocha Database | Compositions",
    },
  ],
};
