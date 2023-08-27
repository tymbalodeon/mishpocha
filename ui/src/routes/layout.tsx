import { component$, Slot, useStyles$ } from "@builder.io/qwik";
import {
  type RequestHandler,
  routeLoader$,
  useContent,
  useLocation,
} from "@builder.io/qwik-city";

import styles from "./styles.css?inline";

export const onGet: RequestHandler = async ({ cacheControl }) => {
  // Control caching for this request for best performance and to reduce hosting costs:
  // https://qwik.builder.io/docs/caching/
  cacheControl({
    // Always serve a cached response by default, up to a week stale
    staleWhileRevalidate: 60 * 60 * 24 * 7,
    // Max once every 5 seconds, revalidate on the server to get a fresh version of this page
    maxAge: 5,
  });
};

export default component$(() => {
  useStyles$(styles);
  const { menu } = useContent();
  const pathname = useLocation().url.pathname;

  return (
    <main>
      <div class="drawer lg:drawer-open">
        <input id="drawer" type="checkbox" class="drawer-toggle" />
        <div class="drawer-content">
          <Slot />
          <label for="drawer" class="btn btn-primary drawer-button lg:hidden">
            Open drawer
          </label>
        </div>
        <div class="drawer-side">
          <label for="drawer" class="drawer-overlay"></label>
          <ul class="menu p-8 w-62 h-full bg-base-200 text-base-content">
            <h1 class="text-4xl pb-12 font-bold">{menu?.text}</h1>
            {menu
              ? menu.items?.map((item, index) => {
                  const title = item.text;
                  const items = item.items;

                  return (
                    <>
                      <p class="menu-label font-bold text-lg">{title}</p>
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
    </main>
  );
});
