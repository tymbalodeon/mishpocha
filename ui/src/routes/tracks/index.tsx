import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";
import { type Track } from "../../schema";

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

    return (
        <>
            <h3 class="font-bold text-xl pl-4 pt-8">Tracks</h3>
            <div class="overflow-x-auto">
                <table class="table">
                    <tbody>
                        {tracks
                            ? tracks.map((track: Track) => {
                                  return (
                                      <DatabaseObject
                                          key={track.id}
                                          data={track}
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
    title: "Mishpocha Database | Tracks",
    meta: [
        {
            name: "Mishpocha Database | Tracks",
            content: "Mishpocha Database | Tracks",
        },
    ],
};
