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
    const response = await fetch(`${apiDomain}/labels`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const labels = useGetApiData().value;
  const id = useLocation().params.id;
  const label = labels.find((label) => label.display == id);

  return (
    <>
      {label ? <DatabaseObject data={label} /> : <p>not found</p>}
      <a href="/labels" class="link pl-4">
        All labels
      </a>
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Labels",
  meta: [
    {
      name: "Mishpocha Database | Labels",
      content: "Mishpocha Database | Labels",
    },
  ],
};
