import { component$ } from "@builder.io/qwik";
import {
    useContent,
    useLocation,
    type DocumentHead,
    routeLoader$,
} from "@builder.io/qwik-city";

export const useGetApiData = routeLoader$(async (requestEvent) => {
    const apiDomain = requestEvent.env.get("API_DOMAIN");

    try {
        const response = await fetch(`http://${apiDomain}`);
        const data = await response.json();
        return data.message;
    } catch (error) {
        return "ERROR: Failed to load data.";
    }
});

export default component$(() => {
    const apiMessage = useGetApiData();

    return (
        <>
            This message has been loaded from the server: {apiMessage.value}
        </>
    );
});

export const head: DocumentHead = {
    title: "Mishpocha Database",
    meta: [
        {
            name: "Mishpocha Database",
            content: "Mishpocha Database",
        },
    ],
};
