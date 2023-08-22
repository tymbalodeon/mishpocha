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
  const { menu } = useContent();
  const pathname = useLocation().url.pathname;
  const apiMessage = useGetApiData();

  return (
    <div class="drawer lg:drawer-open">
      <input id="drawer" type="checkbox" class="drawer-toggle" />
      <div class="drawer-content flex flex-col items-center justify-center">
        <div>
          This message has been loaded from the server: {apiMessage.value}
        </div>
        <label for="drawer" class="btn btn-primary drawer-button lg:hidden">
          Open drawer
        </label>
      </div>
      <div class="drawer-side">
        <label for="drawer" class="drawer-overlay"></label>
        <ul class="menu p-4 w-80 h-full bg-base-200 text-base-content">
          <h1>{menu.text}</h1>
          {menu
            ? menu.items?.map((item, index) => {
                const title = item.text;
                const items = item.items;

                return (
                  <>
                    <p class="menu-label">{title}</p>
                    <ul class="menu bg-base-200 w-56 rounded-box">
                      {items?.map((item) => {
                        const href = item.href;

                        return (
                          <li key={index}>
                            <a
                              href={item.href}
                              class={{
                                "is-active": pathname === href,
                              }}
                            >
                              {item.text}
                            </a>
                          </li>
                        );
                      })}
                    </ul>
                  </>
                );
              })
            : null}
        </ul>
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
