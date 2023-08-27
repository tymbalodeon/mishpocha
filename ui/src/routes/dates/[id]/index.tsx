import { component$ } from "@builder.io/qwik";
import { type DocumentHead, useLocation } from "@builder.io/qwik-city";
import { dates } from "../index.tsx";
import { Date } from "../../../components/date/date";

export default component$(() => {
  const id = useLocation().params.id;
  const date = dates.find((date) => date.localDate == id);

  return (
    <>
      <Date localDate={date.localDate} births={date.births} />
      <a href="/dates" class="link pl-4">
        All dates
      </a>
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
