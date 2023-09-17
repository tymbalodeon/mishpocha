import { component$, Slot, useStyles$ } from "@builder.io/qwik";
import {
  type RequestHandler,
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
          <div class="drawer-button lg:hidden">
            <div class="navbar bg-base-200">
              <div class="flex-1">
                <a href="/" class="btn btn-ghost normal-case text-xl">
                  {menu?.text}
                </a>
              </div>
              <div class="flex-none">
                <label for="drawer">
                  <button class="btn btn-square btn-ghost">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      class="inline-block w-5 h-5 stroke-current"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M4 6h16M4 12h16M4 18h16"
                      ></path>
                    </svg>
                  </button>
                </label>
              </div>
            </div>
          </div>
          <Slot />
        </div>
        <div class="drawer-side lg:bg-base-200">
          <label for="drawer" class="drawer-overlay"></label>
          <h1 class="text-4xl p-8 font-bold">{menu?.text}</h1>
          <ul class="menu p-8 w-62 h-full text-base-content">
            {menu
              ? menu.items?.map((item, index) => {
                  const title = item.text;
                  const items = item.items;

                  return (
                    <li key={index}>
                      <details open>
                        <summary>{title}</summary>
                        <ul class="">
                          {items?.map((item, index) => {
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
                      </details>
                    </li>
                  );
                })
              : null}
          </ul>
        </div>
      </div>
    </main>
  );
});
