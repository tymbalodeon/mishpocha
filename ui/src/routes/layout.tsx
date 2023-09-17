import { component$, Slot, useStyles$, $ } from "@builder.io/qwik";
import { type RequestHandler, useContent } from "@builder.io/qwik-city";
import { Header } from "../components/header.tsx";
import { NavBarItems } from "../components/navbar-items.tsx";

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

function toggleNavBarItems() {
  const navBarItems = document.getElementById("navbar-items");

  if (navBarItems?.classList.contains("hidden")) {
    navBarItems.classList.remove("hidden");
  } else {
    navBarItems?.classList.add("hidden");
  }
}

export default component$(() => {
  useStyles$(styles);
  const { menu } = useContent();

  return (
    <main>
      <div class="drawer lg:drawer-open">
        <input id="drawer" type="checkbox" class="drawer-toggle" />
        <div class="drawer-content">
          <div class="drawer-button lg:hidden">
            <div class="navbar bg-base-200">
              <div class="flex-1">
                <Header text={menu?.text} />
              </div>
              <div class="flex-none">
                <label for="drawer">
                  <button
                    class="btn btn-square btn-ghost"
                    onClick$={$(toggleNavBarItems)}
                  >
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
          <NavBarItems items={menu?.items} navbar={true} />
          <Slot />
        </div>
        <div class="drawer-side lg:bg-base-200">
          <label for="drawer" class="drawer-overlay"></label>
          <Header text={menu?.text} />
          <NavBarItems items={menu?.items} navbar={false} />
        </div>
      </div>
    </main>
  );
});
