import { component$, $, type QwikMouseEvent } from "@builder.io/qwik";
import { useLocation, type ContentMenu } from "@builder.io/qwik-city";

interface MenuLink {
  text: string | undefined;
  href: string;
}

interface NavBarItem {
  text: string | undefined;
  items: MenuLink[];
}

interface NavBarItemsProps {
  items: ContentMenu[] | undefined;
  navbar?: boolean;
}

const toggleDropdown = (event: QwikMouseEvent) => {
  const isNavbar = Boolean(
    (event.target as HTMLElement).id.includes("navbar"),
  );
  let Ids = ["menu-dropdown", "menu-dropdown-toggle"];

  if (isNavbar) {
    Ids = Ids.map((id: string) => `navbar-${id}`);
  }

  const dropdowns = Ids.map((id: string) => document.getElementById(id));

  dropdowns.forEach((dropdown: HTMLElement | null) => {
    const showClass = "menu-dropdown-show";
    if (dropdown?.classList.contains(showClass)) {
      dropdown.classList.remove(showClass);
    } else {
      dropdown?.classList.add(showClass);
    }
  });
};

export const NavBarItems = component$<NavBarItemsProps>((props) => {
  const pathname = useLocation().url.pathname;
  const items = props.items;
  return (
    <ul
      id={props.navbar ? "navbar-items" : ""}
      class={`menu ${
        props.navbar
          ? "menu-horizontal bg-base-200 w-screen hidden lg:hidden"
          : ""
      }`}
    >
      {items
        ? items.map((item) => {
            const title = item.text || "";
            const items = item.items || "";

            return (
              <li key={title} onClick$={$(toggleDropdown)}>
                <span
                  id={`${props.navbar ? "navbar-" : ""}menu-dropdown-toggle`}
                  class="menu-dropdown-toggle menu-dropdown-show"
                >
                  {title}
                </span>
                <ul
                  id={`${props.navbar ? "navbar-" : ""}menu-dropdown`}
                  class="menu-dropdown menu-dropdown-show"
                >
                  {items
                    ? items?.map((item: ContentMenu) => {
                        const href = item.href;

                        return (
                          <li key={href}>
                            <a
                              href={href}
                              class={{
                                active: pathname === href,
                              }}
                            >
                              {item.text}
                            </a>
                          </li>
                        );
                      })
                    : null}
                </ul>
              </li>
            );
          })
        : null}
    </ul>
  );
});
