import { component$ } from "@builder.io/qwik";

interface Date {
  local_date: string;
  births?: string[];
}

export const Date = component$<Date>((props) => {
  return (
    <>
      <h2>{props.localDate}</h2>
      <div class="card w-96 bg-neutral shadow-xl m-4">
        <div class="card-body">
          <h2 class="card-title">{props.localDate}</h2>
          <p>Births: {props.births}</p>
        </div>
      </div>
    </>
  );
});
