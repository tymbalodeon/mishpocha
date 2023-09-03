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
    const response = await fetch(`${apiDomain}/albums`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const albums = useGetApiData().value;
  const id = useLocation().params.id;
  const album = albums.find((album) => album.display == id);

  return (
    <>
      {album ? <DatabaseObject data={album} /> : <p>not found</p>}
      <a href="/albums" class="link pl-4">
        All albums
      </a>
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Albums",
  meta: [
    {
      name: "Mishpocha Database | Albums",
      content: "Mishpocha Database | Albums",
    },
  ],
};
