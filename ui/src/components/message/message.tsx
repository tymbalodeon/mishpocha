import { component$, $ } from "@builder.io/qwik";

interface MessageProps {
  header: string;
  body: string;
  style?: string;
}

function closeMessage(event: QwikMouseEvent) {
  const targetName = (event.target as Element).getAttribute(
    "data-target"
  ) as string;
  const target = document.getElementById(targetName);

  if (!target) {
    return;
  }

  target.style.display = "none";
}

export default component$<MessageProps>((props) => {
  const style = "message " + props.style;

  return (
    <article id={props.header} class={style}>
      <div class="message-header">
        {props.header}
        <button
          onClick$={$(closeMessage)}
          data-target={props.header}
          class="delete"
          aria-label="delete"
        ></button>
      </div>
      <div class="message-body" dangerouslySetInnerHTML={props.body}></div>
    </article>
  );
});
