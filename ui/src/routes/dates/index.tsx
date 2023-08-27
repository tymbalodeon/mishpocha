import { component$ } from "@builder.io/qwik";
import type { DocumentHead } from "@builder.io/qwik-city";
import { Date } from "../../components/date/date";

export const dates = [
  {
    localDate: "1939-11-03",
    births: ["Joe McPhee"],
  },
  {
    localDate: "1944-04-05",
    births: ["Evan Parker"],
  },
  {
    localDate: "1947-03-08",
    births: ["Paul Lytton"],
  },
  {
    localDate: "1947-04-22",
    births: ["Barry Guy"],
  },
  {
    localDate: "1995-06-18",
    births: [],
  },
];

export default component$(() => {
  return (
    <>
      <h2>Dates</h2>
      {dates
        ? dates.map((date) => {
            return <Date localDate={date.localDate} births={date.births} />;
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
