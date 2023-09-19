import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";
import { type Date } from "../../schema";

export const useGetApiData = routeLoader$(async (requestEvent) => {
    const apiDomain = requestEvent.env.get("API_DOMAIN");

    if (!apiDomain) {
        return "API_DOMAIN not specified.";
    }

    try {
        const response = await fetch(`${apiDomain}/dates`);
        return await response.json();
    } catch {
        return [];
    }
});

export default component$(() => {
    const dates = useGetApiData().value;

    return (
        <>
            <h3 class="font-bold text-xl pl-4 pt-8">Dates</h3>
            <div class="overflow-x-auto">
                <table class="table">
                    <tbody>
                        {dates
                            ? dates.map((date: Date) => {
                                  return (
                                      <DatabaseObject
                                          key={date.id}
                                          data={date}
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
    title: "Mishpocha Database | Dates",
    meta: [
        {
            name: "Mishpocha Database | Dates",
            content: "Mishpocha Database | Dates",
        },
    ],
};
