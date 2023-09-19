import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";
import { type Person } from "../../schema";

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
            <h3 class="font-bold text-xl pl-4 pt-8">People</h3>
            <div class="overflow-x-auto">
                <table class="table">
                    <tbody>
                        {people
                            ? people.map((person: Person) => {
                                  return (
                                      <DatabaseObject
                                          key={person.id}
                                          data={person}
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
    title: "Mishpocha Database | People",
    meta: [
        {
            name: "Mishpocha Database | People",
            content: "Mishpocha Database | People",
        },
    ],
};
