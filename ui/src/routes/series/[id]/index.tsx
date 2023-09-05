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
    const response = await fetch(`${apiDomain}/series`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  let series = useGetApiData().value;
  const id = useLocation().params.id;
  series = series.find((series) => series.id == id);

  return (
    <>
      {series ? <DatabaseObject data={series} /> : <p>not found</p>}
      <a href="/series" class="link pl-4">
        All series
      </a>
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Series",
  meta: [
    {
      name: "Mishpocha Database | Series",
      content: "Mishpocha Database | Series",
    },
  ],
};
