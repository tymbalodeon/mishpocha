import { component$ } from "@builder.io/qwik";
import { useLocation } from "@builder.io/qwik-city";

interface MenuLink {
  text: string;
  href: string;
}

interface NavBarItem {
  text: string;
  items: MenuLink[];
}

interface NavBarItemsProps {
  items?: NavBarItem[];
  navbar?: boolean;
}

export const NavBarItems = component$<NavBarItemsProps>((props) => {
  const pathname = useLocation().url.pathname;
  const items = props.items;

  return (
    <div class="w-vw">
      <ul
        id={!props.navbar ? "" : "navbar-items"}
        class={`menu ${
          !props.navbar
            ? "p-8 w-62 h-full"
            : "menu-horizontal bg-base-200 hidden lg:hidden"
        }`}
      >
        {items?.map((item, index) => {
          const title = item.text;
          const items = item.items;

          return (
            <li key={index}>
              <div>
                <details open>
                  <summary>{title}</summary>
                  <ul>
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
              </div>
            </li>
          );
        })}
      </ul>
    </div>
  );
});
