import { component$ } from "@builder.io/qwik";
import type { DocumentHead } from "@builder.io/qwik-city";

export default component$(() => {
  return (
    <>
      <div class="section">SCHOOLS</div>
      <div class="buttons">
        <a class="button is-primary">Primary</a>
        <a class="button is-link">Link</a>
      </div>
    </>
  );
});

export const head: DocumentHead = {
  title: "Courseware Web App",
  meta: [
    {
      name: "UPenn Courseware Web App",
      content: "Courseware Web App",
    },
  ],
};
