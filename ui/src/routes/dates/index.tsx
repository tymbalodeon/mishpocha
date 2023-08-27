import { component$ } from "@builder.io/qwik";
import type { DocumentHead } from "@builder.io/qwik-city";

const dates = [
    {
        "local_date": "1939-11-03",
        "birthdays": [
            "Joe McPhee"
        ]
    },
    {
        "local_date": "1944-04-05",
        "birthdays": [
            "Evan Parker"
        ]
    },
    {
        "local_date": "1947-03-08",
        "birthdays": [
            "Paul Lytton"
        ]
    },
    {
        "local_date": "1947-04-22",
        "birthdays": [
            "Barry Guy"
        ]
    },
    {
        "local_date": "1995-06-18",
        "birthdays": []
    }
];

export default component$(() => {
    return (
        <>
            <h2>Dates</h2>
            {
                dates ? (
                    dates.map(date => {
                        return (
                            <div class="card w-96 bg-neutral shadow-xl m-4">
                                <div class="card-body">
                                    <h2 class="card-title">{date.local_date}</h2>
                                    <p>Births: {date.birthdays}</p>
                                </div>
                            </div>
                        )
                    })
                ) : null
            }
        </>
    )
});

export const head: DocumentHead = {
    title: "Mishpocha Database | Dates",
    meta: [
        {
            name: "Mishpocha Database | Dates",
            content: "Mishpocha Database | Dates",
        },
    ],
};
