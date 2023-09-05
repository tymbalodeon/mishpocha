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
    const response = await fetch(`${apiDomain}/dates`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const dates = useGetApiData().value;
  const id = useLocation().params.id;
  const date = dates.find((date) => date.id == id);

  return (
    <>
      {date ? <DatabaseObject data={date} /> : <p>not found</p>}
      <a href="/dates" class="link pl-4">
        All dates
      </a>
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Dates",
  meta: [
    {
      name: "Mishpocha Database | Dates",
      content: "Mishpocha Database | Dates",
    },
  ],
};
