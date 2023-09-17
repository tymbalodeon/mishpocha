import { component$ } from "@builder.io/qwik";

interface HeaderProps {
  text: string;
}

export const Header = component$<HeaderProps>((props) => {
  const text = props.text;

  return (
    <a href="/">
      <h1 class="text-2xl lg:text-4xl p-4 lg:p-8 font-bold">{text}</h1>
    </a>
  );
});
