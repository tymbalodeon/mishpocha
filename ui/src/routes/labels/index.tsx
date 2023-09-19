import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";

export const useGetApiData = routeLoader$(async (requestEvent) => {
    const apiDomain = requestEvent.env.get("API_DOMAIN");

    if (!apiDomain) {
        return "API_DOMAIN not specified.";
    }

    try {
        const response = await fetch(`${apiDomain}/labels`);
        return await response.json();
    } catch {
        return [];
    }
});

export default component$(() => {
    const labels = useGetApiData().value;

    return (
        <>
            <h3 class="font-bold text-xl pl-4 pt-8">Labels</h3>
            <div class="overflow-x-auto">
                <table class="table">
                    <tbody>
                        {labels
                            ? labels.map((label, index) => {
                                  label.compact = true;
                                  return (
                                      <DatabaseObject
                                          key={index}
                                          data={label}
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
    title: "Mishpocha Database | Labels",
    meta: [
        {
            name: "Mishpocha Database | Labels",
            content: "Mishpocha Database | Labels",
        },
    ],
};
