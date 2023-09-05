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
    const response = await fetch(`${apiDomain}/tracks`);
    return await response.json();
  } catch {
    return [];
  }
});

export default component$(() => {
  const tracks = useGetApiData().value;
  const id = useLocation().params.id;
  const track = tracks.find((track) => track.id == id);

  return (
    <>
      {track ? <DatabaseObject data={track} /> : <p>not found</p>}
      <a href="/tracks" class="link pl-4">
        All tracks
      </a>
    </>
  );
});

export const head: DocumentHead = {
  title: "Mishpocha Database | Tracks",
  meta: [
    {
      name: "Mishpocha Database | Tracks",
      content: "Mishpocha Database | Tracks",
    },
  ],
};
