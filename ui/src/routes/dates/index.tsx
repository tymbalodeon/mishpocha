import { component$ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import { Date } from "../../components/date/date";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  const response = await fetch(`${apiDomain}/dates`);
  return await response.json();
});

export default component$(() => {
  const dates = useGetApiData().value;

  return (
    <>
      <h2 class="font-bold text-xl pl-4 pt-8">Dates</h2>
      {dates
        ? dates.map((date, index) => {
            return (
              <Date
                key={index}
                localDate={date.display}
                births={date.births}
                compact={true}
              />
            );
          })
        : null}
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
