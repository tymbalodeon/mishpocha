import { component$ } from "@builder.io/qwik";
import {
  type DocumentHead,
  useLocation,
  routeLoader$,
} from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";
import { DatabaseProps } from "../../schema.ts";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    const response = await fetch(`${apiDomain}/artists`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const artists = useGetApiData().value;
  const id = useLocation().params.id;
  const artist = artists.find((artist) => artist.display == id);

  return (
    <>
      {artist ? <DatabaseObject data={artist} /> : <p>not found</p>}
      <a href="/artists" class="link pl-4">
        All artists
      </a>
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Artists",
  meta: [
    {
      name: "Mishpocha Database | Artists",
      content: "Mishpocha Database | Artists",
    },
  ],
};
