import { component$ } from "@builder.io/qwik";
import {
  type DocumentHead,
  useLocation,
  routeLoader$,
} from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";

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
  const id = useLocation().params.id;
  const instrument = instruments.find((instrument) => instrument.id == id);

  return (
    <>{instrument ? <DatabaseObject data={instrument} /> : <p>not found</p>}</>
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
