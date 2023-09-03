import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";

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
  const series = useGetApiData().value;

  return (
    <>
      <h2 class="font-bold text-xl pl-4 pt-8">Series</h2>
      {series
        ? series.map((series, index) => {
            series.compact = true;
            return <DatabaseObject key={index} data={series} />;
          })
        : null}
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