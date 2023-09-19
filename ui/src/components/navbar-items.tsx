import { component$ } from "@builder.io/qwik";
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

export const NavBarItems = component$<NavBarItemsProps>((props) => {
    const pathname = useLocation().url.pathname;
    const items = props.items;

    return (
        <ul
            id={props.navbar ? "navbar-items" : ""}
            class={`menu ${
                props.navbar
                    ? "menu-horizontal bg-base-200 hidden lg:hidden"
                    : ""
            }`}
        >
            {items
                ? items.map((item) => {
                      const title = item.text || "";
                      const items = item.items || "";

                      return (
                          <li key={title}>
                              <details open>
                                  <summary>{title}</summary>
                                  <ul>
                                      {items
                                          ? items?.map((item: ContentMenu) => {
                                                  const href = item.href;

                                                  return (
                                                      <li key={href}>
                                                          <a
                                                              href={href}
                                                              class={{
                                                                  active:
                                                                      pathname ===
                                                                      href,
                                                              }}
                                                          >
                                                              {item.text}
                                                          </a>
                                                      </li>
                                                  );
                                              })
                                          : null}
                                  </ul>
                              </details>
                          </li>
                      );
                  })
                : null}
        </ul>
    );
});
