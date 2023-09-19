import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";
import { type Album } from "../../schema";

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

    return (
        <>
            <h3 class="font-bold text-xl pl-4 pt-8">Albums</h3>
            <div class="overflow-x-auto">
                <table class="table table-zebra">
                    <tbody>
                        {albums
                            ? albums.map((album: Album) => {
                                  return (
                                      <DatabaseObject
                                          key={album.id}
                                          data={album}
                                          compact={true}
                                      />
                                  );
                              })
                            : null}
                    </tbody>
                </table>
            </div>
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
