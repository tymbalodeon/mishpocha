import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");
  const id = requestEvent.params.id;

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/tracks/${id}`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const track = useGetApiData().value;

  return <>{track ? <DatabaseObject data={track} /> : <p>not found</p>}</>;
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Track",
  meta: [
    {
      name: "Mishpocha Database | Track",
      content: "Mishpocha Database | Track",
    },
  ],
};
