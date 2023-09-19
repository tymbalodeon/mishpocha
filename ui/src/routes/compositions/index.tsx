import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { DatabaseObject } from "../../components/database-object";

export const useGetApiData = routeLoader$(async (requestEvent) => {
    const apiDomain = requestEvent.env.get("API_DOMAIN");

    if (!apiDomain) {
        return "API_DOMAIN not specified.";
    }

    try {
        const response = await fetch(`${apiDomain}/compositions`);
        return await response.json();
    } catch {
        return [];
    }
});

export default component$(() => {
    const compositions = useGetApiData().value;

    return (
        <>
            <div class="p-8">
                <h3 class="font-bold text-xl pl-4 pt-8">Compositions</h3>
                <div class="overflow-x-auto">
                    <table class="table table-zebra">
                        <thead>
                            <tr>
                                {keys.map((key, index) => {
                                    key = key.replace("_", " ");

                                    return <th key={index}>{key}</th>;
                                })}
                            </tr>
                        </thead>
                        <tbody>
                            {compositions
                                ? compositions.map((composition, index) => {
                                      composition.compact = true;
                                      return (
                                          <DatabaseObject
                                              key={index}
                                              data={composition}
                                          />
                                      );
                                  })
                                : null}
                        </tbody>
                    </table>
                </div>
            </div>
        </>
    );
});

export const head: DocumentHead = {
    title: "Mishpocha Database | Compositions",
    meta: [
        {
            name: "Mishpocha Database | Compositions",

            content: "Mishpocha Database | Compositions",
        },
    ],
};
