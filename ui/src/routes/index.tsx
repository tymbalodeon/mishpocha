import { component$ } from "@builder.io/qwik";
import {
  useContent,
  useLocation,
  type DocumentHead,
  routeLoader$,
} from "@builder.io/qwik-city";

export const useGetApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");

  if (!apiDomain) {
    return "API_DOMAIN not specified.";
  }

  try {
    return await fetch(apiDomain).then((response) => response.text());
  } catch {
    return "API not running.";
  }
});

export default component$(() => {
  const apiMessage = useGetApiData();

  return (
    <div class="hero min-h-screen">
      <div class="hero-content">
        <div class="max-w-md">
          <p class="py-6">{apiMessage.value}</p>
        </div>
      </div>
    </div>
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
