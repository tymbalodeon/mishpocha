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
    const response = await fetch(`${apiDomain}/compositions`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const compositions = useGetApiData().value;
  const id = useLocation().params.id;
  const composition = compositions.find((composition) => composition.id == id);

  return (
    <>
      {composition ? <DatabaseObject data={composition} /> : <p>not found</p>}
    </>
  );
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
