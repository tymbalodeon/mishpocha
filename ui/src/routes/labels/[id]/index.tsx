import { component$ } from "@builder.io/qwik";
import {
  type DocumentHead,
  useLocation,
  routeLoader$,
} from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");
  const id = requestEvent.params.id;

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/labels/${id}`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const label = useGetApiData().value;

  return <>{label ? <DatabaseObject data={label} /> : <p>not found</p>}</>;
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Label",
  meta: [
    {
      name: "Mishpocha Database | Label",
      content: "Mishpocha Database | Label",
    },
  ],
};
