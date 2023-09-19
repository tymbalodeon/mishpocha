import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../../components/database-object";
import { type Series } from "../../../schema";

export const useGetApiData = routeLoader$(async (requestEvent) => {
    const apiDomain = requestEvent.env.get("API_DOMAIN");
    const id = requestEvent.params.id;

    if (!apiDomain) {
        return "API_DOMAIN not specified.";
    }

    try {
        const response = await fetch(`${apiDomain}/series/${id}`);
        return await response.json();
    } catch {
        return [];
    }
});

export default component$(() => {
    const series = useGetApiData().value as Series;

    return <>{series ? <DatabaseObject data={series} /> : <p>not found</p>}</>;
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
