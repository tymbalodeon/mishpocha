import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/people`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const people = useGetApiData().value;

  return (
    <>
      <h2 class="font-bold text-xl pl-4 pt-8">People</h2>
      {people
        ? people.map((person, index) => {
            person.compact = true;
            return <DatabaseObject key={index} data={person} />;
          })
        : null}
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | People",
  meta: [
    {
      name: "Mishpocha Database | People",
      content: "Mishpocha Database | People",
    },
  ],
};