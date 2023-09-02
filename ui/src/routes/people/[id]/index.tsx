import { component$ } from "@builder.io/qwik";
import {
  type DocumentHead,
  useLocation,
  routeLoader$,
} from "@builder.io/qwik-city";
import { Person } from "../../../components/person/person";
import { Person as PersonObject } from "../../schema.ts";

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
  const id = useLocation().params.id;
  const person = people.find((person) => person.full_name == id);

  return (
    <>
      {person ? <Person data={person} /> : <p>not found</p>}
      <a href="/people" class="link pl-4">
        All people
      </a>
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Person",
  meta: [
    {
      name: "Mishpocha Database | Person",
      content: "Mishpocha Database | Person",
    },
  ],
};
