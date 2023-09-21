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
    const response = await fetch(`${apiDomain}/instruments`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const instruments = useGetApiData().value as MishpochaObject[];

  return <DatabaseObjects objects={instruments} title="Instruments" />;
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Instruments",
  meta: [
    {
      name: "Mishpocha Database | Instruments",

      content: "Mishpocha Database | Instruments",
    },
  ],
};
