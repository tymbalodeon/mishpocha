import { component$ } from "@builder.io/qwik";

interface Date {
  local_date: string;
  births?: string[];
}

export const Date = component$<Date>((props) => {
  return (
    <a href={"/dates/" + props.localDate}>
      <div class="card w-96 bg-neutral shadow-xl m-4">
        <div class="card-body">
          <h2 class="card-title">{props.localDate}</h2>
          {!props.compact ? <p>Births: {props.births}</p> : null}
        </div>
      </div>
    </a>
  );
});
