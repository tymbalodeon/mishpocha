import { component$ } from "@builder.io/qwik";
import { useContent, useLocation } from "@builder.io/qwik-city";

export default component$(() => {
  const { menu } = useContent();
  const pathname = useLocation().url.pathname;

  return (
    <aside class="menu">
      <div class="">
        <img
          class="p-4 has-background-primary"
          src="/upenn-logo.png"
          alt="University of Pennsylvania Logo"
          width="340"
        />
        <div class="content p-4">
          <h1>{menu?.text}</h1>
        </div>
      </div>

      {menu
        ? menu.items?.map((item) => {
            const title = item.text;
            const items = item.items;

            return (
              <>
                <p class="menu-label">{title}</p>
                <ul class="menu-list">
                  {items?.map((item) => {
                    const href = item.href;

                    return (
                      <li>
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
    </aside>
  );
});
