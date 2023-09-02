import { component$ } from "@builder.io/qwik";

interface Person {
  full_name: string;
}

export const Person = component$<Person>((props) => {
  const data = (
    <div class="card w-96 bg-neutral shadow-xl m-4">
      <div class="card-body">
        <h2 class="card-title">{props.localDate}</h2>
        {!props.compact ? (
          <p>Births: {props.births.map((person) => person.full_name)}</p>
        ) : null}
      </div>
    </div>
  );

  if (!props.compact) {
    return data;
  }

  return <a href={"/person/" + props.localDate}>{data}</a>;
});
