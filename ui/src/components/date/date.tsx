import { component$ } from "@builder.io/qwik";

interface Date {
    localDate: string;
    births?: string[];
    compact?: boolean;
}

export const Date = component$<Date>((props) => {
    const data = (
        <div class="card w-96 bg-neutral shadow-xl m-4">
            <div class="card-body">
                <h2 class="card-title">{props.localDate}</h2>
                {!props.compact ? <p>Births: {props.births}</p> : null}
            </div>
        </div>
    );

    if (!props.compact) {
        return data;
    }

    return (
        <a href={"/dates/" + props.localDate}>
            {data}
        </a>
    );
});
