import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";

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
  const instruments = useGetApiData().value;

  return (
    <>
      <h2 class="font-bold text-xl pl-4 pt-8">Instruments</h2>
      {instruments
        ? instruments.map((instrument, index) => {
            instrument.compact = true;
            return <DatabaseObject key={index} data={instrument} />;
          })
        : null}
    </>
  );
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
